# This creates and initializes a walk map, as well as provides
# functions to add and edit waypoints

class window.SanpoMap
  # Default options
  # TODO: get sensible defaults for centerLat/Lng
  options:
    waypoints: []
    centerLat: 35.640
    centerLng: 139.667
    zoomLevel: 9
    isNewWalk: false
    walkId: -1

  constructor: (options) ->
    # If we get passed an options object, set options accordingly
    # Options that haven't been explicitly set use the default values
    if options
      if options.waypoints != undefined
        @options.waypoints = options.waypoints
      if options.centerLat != undefined
        @options.centerLat = options.centerLat
      if options.centerLng != undefined
        @options.centerLng = options.centerLng
      if options.isNewWalk != undefined
        @options.isNewWalk = options.isNewWalk
      if options.walkId != undefined
        @options.walkId = options.walkId
      if options.zoomLevel != undefined
        @options.zoomLevel = options.zoomLevel

    # Initialize the map itself
    @centerPoint = new google.maps.LatLng(@options.centerLat, @options.centerLng)
    mapOptions =
      zoom: @options.zoomLevel
      center: @centerPoint
      mapTypeId: google.maps.MapTypeId.ROADMAP
      panControl: false
      scrollwheel: false
      streetViewControl: false
      zoomControlOptions:
        position: google.maps.ControlPosition.LEFT_CENTER
    @map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)

    # Initialize the polyline to draw our route
    polyOptions =
      strokeColor: '#00f'
      strokeOpacity: 0.5
      strokeWeight: 5
    @poly = new google.maps.Polyline(polyOptions)
    @poly.setMap(@map)

    # if a path already exists, build it here and zoom the map to fit it
    if @options.waypoints.length > 0
      @addLatLngToPath(new google.maps.LatLng(waypoint.lat, waypoint.lon)) for waypoint in @options.waypoints
      @updateStartGoalIcons()
      @zoomAndCenterMapToFitPath()

    # Keep track of changes to walk so that we only update the db if needed
    @walkChanged = false

    # If this is a new walk form, we should switch to edit mode right away
    if @options.isNewWalk
      $('.editButtonContainer').hide()
      @initGeocoder()
      @setEditMode(true)

    # Handle clicks on the edit button
    $('#map_controls .editButton').click (event) =>
      @toggleEditMode()
      event.stopPropagation()
      event.preventDefault()

  # Setup the search field so that the user can focus the map on desired location
  initGeocoder: =>
    @geocoder = new google.maps.Geocoder();

    $("#mapSearchField").removeClass("hidden")
    $("#mapLocationSearchForm").submit (event) =>
      @processGeocoding()
      event.stopPropagation()
      event.preventDefault()

  processGeocoding: =>
    address = $("#mapLocationSearchForm .searchField").val()
    @geocoder.geocode((
        address: address
      ), (results, status) =>
        if status == google.maps.GeocoderStatus.OK
          @map.setCenter(results[0].geometry.location)
          @map.setZoom(15)
        else
          alert("Couldn't locate that place: " + status);
    )

  # If we're creating a new walk, enable the save button if there are at least 2 waypoints
  mapClickHandler: (event) =>
    @addLatLngToPath(event.latLng)
    if @poly.getPath().getLength() >= 2
      $('#newWalkSubmit:disabled').removeAttr("disabled")

  # Add a vertex to the polyline. If we're in edit mode, also add the draggable handler
  addLatLngToPath: (latLng) ->
    path = @poly.getPath()
    path.push(latLng)
    if @editMode
      @createMarkerVertex(latLng).editIndex = path.getLength() - 1
      @walkChanged = true
      @updateVertexIcons()
    # console.log "path: #{path.b.toString()}"

  toggleEditMode: ->
    _gaq.push(['_trackEvent', 'SanpoMap', 'Edit mode toggled'])
    @setEditMode(!@editMode)

  # Check if we're not going into edit mode twice by mistake
  setEditMode: (editMode = true) ->
    if editMode != @editMode
      @editMode = editMode
      if @editMode
        @startEditMode()
      else
        @stopEditMode()
    else
      console.log "Requested mode already active, not setting again"

  startEditMode: =>
    @clearMarkers()
    @createMarkers()
    # console.log "Starting edit mode"

    google.maps.event.addListener(@map, 'click', @mapClickHandler)
    @map.draggableCursor = 'crosshair'
    @map.draggingCursor = 'move'
    $('#map_container').addClass 'editMode'
    $('.editButton').removeClass('primary').addClass('danger').text("Save the changes")

  stopEditMode: =>
    @clearMarkers()
    # console.log "Stopping edit mode"

    google.maps.event.clearListeners(@map, 'click')
    @map.draggableCursor = 'auto'
    @map.draggingCursor = 'auto'
    $('#map_container').removeClass 'editMode'
    $('.editButton').removeClass('danger').addClass('primary').text("Edit the route")

    @updateStartGoalIcons()
    @saveUpdatedPath()

  # Save waypoints to the form (if new walk) or to the db (if updating a walk)
  saveUpdatedPath: ->
    # console.log "Saving the path: #{@poly.getPath().b.toString()}"
    pathLength = google.maps.geometry.spherical.computeLength(map.poly.getPath().getArray()).toFixed()
    # console.log "Path length: #{pathLength}"
    if @options.isNewWalk
      # console.log "This is a new walk: saving waypoints into the form"
      $('#waypoints_container').html('')
      @poly.getPath().forEach (vertex, index) ->
        $('#waypoints_container').append(
          "<input type='hidden' id='walk_waypoints_attributes_#{index}_latitude' name='walk[waypoints_attributes][#{index}][latitude]' value='#{vertex.lat()}' />" \
          + "<input type='hidden' id='walk_waypoints_attributes_#{index}_longitude' name='walk[waypoints_attributes][#{index}][longitude]' value='#{vertex.lng()}' />" \
          + "<input type='hidden' id='walk_waypoints_attributes_#{index}_step_num' name='walk[waypoints_attributes][#{index}][step_num]' value='#{index}' />" \
          + "<input type='hidden' id='walk_length' name='walk[length]' value='#{pathLength}' />"
        )
      _gaq.push(['_trackEvent', 'SanpoMap', 'Creating a new walk'])
      return 1
    else if @walkChanged
      # console.log "Updating a walk: sending an ajax update request"
      waypoints_to_save = []
      @poly.getPath().forEach (vertex, index) ->
        waypoints_to_save.push(
          latitude: vertex.lat()
          longitude: vertex.lng()
          step_num: index
        )
      if @options.walkId
        $.ajax(
          type: 'POST',
          url: "/walks/#{@options.walkId}/update_waypoints",
          data: 'waypoints=' + JSON.stringify(waypoints_to_save) + '&length=' + pathLength,
          success: (data) ->
            console.log "Route saved"
        )
        _gaq.push(['_trackEvent', 'SanpoMap', 'Updating an existing walk'])
        return 1
      else
        console.log "This shouldn't happen: want to update a walk's waypoints, but don't have a walkId"
        return -1
    else
      _gaq.push(['_trackEvent', 'SanpoMap', 'No changes to a walk'])
      console.log "No changes!"
      return 0

  zoomAndCenterMapToFitPath: ->
    bounds = new google.maps.LatLngBounds()
    @poly.getPath().forEach (vertex, index) ->
      bounds.extend(vertex)
    @map.fitBounds(bounds)

  #
  # ------------- Vertex management --------------------------------------------------
  #
  createMarkers: ->
    @poly.getPath().forEach (vertex, index) =>
      @createMarkerVertex(vertex).editIndex = index
    if @editMode
      @updateVertexIcons()

  clearMarkers: ->
    @poly.getPath().forEach (vertex, index) ->
      if vertex.marker
        vertex.marker.setMap(null)
        vertex.marker = undefined

  updateStartGoalIcons: ->
    path = @poly.getPath()
    start = path.getAt(0)
    goal = path.getAt(path.getLength() - 1)

    @createMarkerVertex(start, (
      addListeners: false
      icon: @startImage
      draggable: false
    ))
    @createMarkerVertex(goal, (
      addListeners: false
      icon: @goalImage
      draggable: false
    ))

  updateVertexIcons: ->
    path = @poly.getPath()
    path.forEach (vertex, index) =>
      if index == 0
        vertex.marker.type = 'start'
        vertex.marker.setIcon(@vertexStartImage)
      else if index == (path.getLength() - 1)
        vertex.marker.type = 'goal'
        vertex.marker.setIcon(@vertexGoalImage)
      else
        vertex.marker.type = 'normal'
        vertex.marker.setIcon(@vertexImage)


  createMarkerVertex: (point, _markerOptions) ->
    markerOptions = (
      addListeners: true
      icon: @vertexImage
      draggable: true
    )
    if _markerOptions
      if _markerOptions.addListeners != undefined
        markerOptions.addListeners = _markerOptions.addListeners
      if _markerOptions.icon != undefined
        markerOptions.icon = _markerOptions.icon
      if _markerOptions.draggable != undefined
        markerOptions.draggable = _markerOptions.draggable

    vertex = point.marker
    if !vertex
      vertex = new google.maps.Marker(
        position: point
        map: @map
        icon: markerOptions.icon
        draggable: markerOptions.draggable
        raiseOnDrag: false
        type: 'normal'
        self: this # OMG, this is the ugliest thing ever
      )
      if markerOptions.addListeners
        google.maps.event.addListener(vertex, "mouseover", @vertexMouseOver)
        google.maps.event.addListener(vertex, "mouseout", @vertexMouseOut)
        google.maps.event.addListener(vertex, "drag", @vertexDrag)
        google.maps.event.addListener(vertex, "dragend", @vertexDragEnd)
        google.maps.event.addListener(vertex, "rightclick", @vertexRightClick)
      point.marker = vertex
      return vertex
    vertex.setPosition(point)

  vertexImage: new google.maps.MarkerImage(
    '/assets/vertex.png',
    new google.maps.Size(16, 16),
    new google.maps.Point(0, 0),
    new google.maps.Point(8, 8)
  )

  vertexOverImage: new google.maps.MarkerImage(
    '/assets/vertex_over.png',
    new google.maps.Size(16, 16),
    new google.maps.Point(0, 0),
    new google.maps.Point(8, 8)
  )

  startImage: new google.maps.MarkerImage(
    '/assets/start.png',
    new google.maps.Size(32, 35),
    new google.maps.Point(0, 0),
    new google.maps.Point(24, 27)
  )

  vertexStartImage: new google.maps.MarkerImage(
    '/assets/vertex_start.png',
    new google.maps.Size(32, 35),
    new google.maps.Point(0, 0),
    new google.maps.Point(24, 27)
  )

  vertexStartOverImage: new google.maps.MarkerImage(
    '/assets/vertex_start_over.png',
    new google.maps.Size(32, 35),
    new google.maps.Point(0, 0),
    new google.maps.Point(24, 27)
  )

  goalImage: new google.maps.MarkerImage(
    '/assets/goal.png',
    new google.maps.Size(28, 35),
    new google.maps.Point(0, 0),
    new google.maps.Point(20, 27)
  )

  vertexGoalImage: new google.maps.MarkerImage(
    '/assets/vertex_goal.png',
    new google.maps.Size(28, 35),
    new google.maps.Point(0, 0),
    new google.maps.Point(20, 27)
  )

  vertexGoalOverImage: new google.maps.MarkerImage(
    '/assets/vertex_goal_over.png',
    new google.maps.Size(28, 35),
    new google.maps.Point(0, 0),
    new google.maps.Point(20, 27)
  )

  vertexMouseOver: ->
    if this.type == 'normal'
      this.setIcon(this.self.vertexOverImage)
    else if this.type == 'start'
      this.setIcon(this.self.vertexStartOverImage)
    else if this.type == 'goal'
      this.setIcon(this.self.vertexGoalOverImage)

  vertexMouseOut: ->
    if this.type == 'normal'
      this.setIcon(this.self.vertexImage)
    else if this.type == 'start'
      this.setIcon(this.self.vertexStartImage)
    else if this.type == 'goal'
      this.setIcon(this.self.vertexGoalImage)

  vertexDrag: ->
    vertex = this.getPosition()
    vertex.marker = this
    this.self.poly.getPath().setAt(this.editIndex, vertex)
    this.self.walkChanged = true

  vertexDragEnd:  ->
    # console.log "ending drag - path: #{this.self.poly.getPath().getArray().toString()}"

  vertexRightClick: ->
    polyline = this.self.poly
    vertex = polyline.getPath().getAt(this.editIndex)

    # console.log "Removing at #{this.editIndex}"
    polyline.getPath().removeAt(this.editIndex)

    this.setMap(null)
    polyline.getPath().forEach (vertex, index) ->
      if vertex.marker
        vertex.marker.editIndex = index

    if polyline.getPath().getLength() == 1
      polyline.getPath().pop().marker.setMap(null)

    this.self.walkChanged = true
    this.self.updateVertexIcons()
    if polyline.getPath().getLength() < 2
      $('#newWalkSubmit').attr("disabled", "disabled")
