# This creates and initializes a walk map, as well as provides
# functions to add and edit waypoints

class window.SanpoMap
  constructor: (centerLat, centerLng, @waypoints = [], editMode = false) ->
    @centerPoint = new google.maps.LatLng(centerLat, centerLng)
    options =
      zoom: 17
      center: @centerPoint
      mapTypeId: google.maps.MapTypeId.ROADMAP
      panControl: false
      scrollwheel: false
      streetViewControl: false
      zoomControlOptions:
        position: google.maps.ControlPosition.LEFT_CENTER

    @map = new google.maps.Map(document.getElementById('map_canvas'), options)

    polyOptions =
      strokeColor: '#f00'
      strokeOpacity: 0.5
      strokeWeight: 5

    @poly = new google.maps.Polyline(polyOptions)
    @poly.setMap(@map)

    # if a path already exists, build it here
    if @waypoints.length > 0
      @addLatLngToPath(new google.maps.LatLng(waypoint.lat, waypoint.lon)) for waypoint in @waypoints

    @setEditMode(editMode)
    $('#map_controls .editButton').click (event) =>
      @toggleEditMode()
      event.stopPropagation()
      event.preventDefault()

  mapClickHandler: (event) =>
    @clearMarkers()
    @addLatLngToPath(event.latLng)
    @createMarkers()

  addLatLngToPath: (latLng) ->
    path = @poly.getPath()
    path.push(latLng)
    console.log "path: #{path.b.toString()}"

    marker = new google.maps.Marker(
      position: event.latLng
      title: '#' + path.getLength()
      map: @map
    )

  toggleEditMode: ->
    @setEditMode(!@editMode)

  setEditMode: (editMode = true) ->
    if editMode != @editMode
      @editMode = editMode
      if @editMode
        console.log "Starting edit mode"
        @startEditMode()
      else
        console.log "Stopping edit mode"
        @stopEditMode()
    else
      console.log "Requested mode already active, not setting again"

  startEditMode: =>
    @createMarkers()

    google.maps.event.addListener(@map, 'click', @mapClickHandler)
    @map.draggableCursor = 'crosshair'
    @map.draggingCursor = 'move'
    $('#map_container').addClass 'editMode'
    $('.editButton').removeClass('primary').addClass('danger').text("Save the changes")

  stopEditMode: =>
    @clearMarkers()
    console.log "Stopping edit mode - path: #{@poly.getPath().b.toString()}"

    google.maps.event.clearListeners(@map, 'click')
    @map.draggableCursor = 'auto'
    @map.draggingCursor = 'auto'
    $('#map_container').removeClass 'editMode'
    $('.editButton').removeClass('danger').addClass('primary').text("Edit the route")

  #
  # --------------------- Vertex management ------------------------
  #
  createMarkers: ->
    @poly.getPath().forEach (vertex, index) =>
      @createMarkerVertex(vertex).editIndex = index

  clearMarkers: ->
    @poly.getPath().forEach (vertex, index) ->
      if vertex.marker
        vertex.marker.setMap(null)
        vertex.marker = undefined

  createMarkerVertex: (point) ->
    vertex = point.marker

    if !vertex
      vertex = new google.maps.Marker(
        position: point
        map: @map
        poly: @poly
        icon: @vertexImage
        draggable: true
        raiseOnDrag: false
      )
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

  vertexMouseOver: ->
    console.log "vertexMouseOver"

  vertexMouseOut: ->
    console.log "vertexMouseOut"

  vertexDrag: ->
    vertex = this.getPosition()
    vertex.marker = this
    this.poly.getPath().setAt(this.editIndex, vertex)

  vertexDragEnd:  ->
    console.log "ending drag - path: #{this.poly.getPath().b.toString()}"

  vertexRightClick: ->
    console.log "vertexRightClick"
