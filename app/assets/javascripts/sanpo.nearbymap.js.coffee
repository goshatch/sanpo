if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.NearbyWalksMap extends BaseMap
  options:
    centerLat: 0
    centerLng: 0
    zoomLevel: 12
    search: null

  constructor: (options) ->
    if options
      if options.centerLat != undefined
        @options.centerLat = options.centerLat
      if options.centerLng != undefined
        @options.centerLng = options.centerLng
      if options.zoomLevel != undefined
        @options.zoomLevel = options.zoomLevel
      if options.search != undefined
        @options.search = options.search
        console.log "Setting search to #{options.search}"

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
    console.log "Creating a map centered on: #{mapOptions.center.lat()}x#{mapOptions.center.lng()}"
    @gmap = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)
    console.log "New map is centered on: #{@gmap.center.lat()}x#{@gmap.center.lng()}"
    google.maps.event.addListener(@gmap, 'center_changed', =>
      console.log "Now the map is centered on: #{@gmap.center.lat()}x#{@gmap.center.lng()}"
    )
    # @bounds = new google.maps.LatLngBounds()
    @addWalkMarkersToMap()
    geocoderOptions =
      placeholder: "Where do you want to go?"
      cssClass: "large"
      buttonText: "Search"
    @geocoder = new Sanpo.MapSearchField(@gmap, geocoderOptions)
    window.Sanpo.geolocateAndCenterMap(@gmap)

    super

  addWalkMarkersToMap: ->
    # url = "/walks.json"
    # if @options.search
    #   url = "#{url}?search=#{@options.search}"
    # url = "/walks.json?lat=#{@gmap.center.lat()}&lng=#{@gmap.center.lng()}"
    url = "/walks.json?all=true"
    # console.log "Ajax url: #{url}"
    $.getJSON(url, (walks) =>
      @createInfoBubble(walk) for walk in walks
    )
    # @gmap.fitBounds(@bounds)

  # Creates the infobubble for the walk passed as parameter and adds it to @gmap.
  # The walk must come from the JSON list in addWalkMarkersToMap
  createInfoBubble: (walk) ->
    vertex = new google.maps.LatLng(walk.latitude, walk.longitude)
    infoBubble = new InfoBubble(
      map: @gmap
      position: vertex
      shadowStyle: 0
      arrowSize: 10
      arrowPosition: 15
      borderColor: "#339BB9"
      padding: 5
      minWidth: 160
      maxWidth: 200
      borderWidth: 5
      borderRadius: 10
      hideCloseButton: true
      disableAutoPan: true
      content: @infoBubbleContentForWalk(walk)
    )
    infoBubble.open()
    # @bounds.extend(vertex)

  # Generates the content for the walk's infobubble (icon, description, link).
  # The walk must come from the JSON list as defined in addWalkMarkersToMap
  infoBubbleContentForWalk: (walk) ->
    content = "<div class='walkInfoBubble' id='walkInfoBubble_#{walk.id}'>"
    content += "<a href='#{walk.link}' title='#{walk.title}'>"
    content += "<img src='#{walk.icon}' class='icon' />"
    content += "<div class='info'>"
    title = walk.title
    if title.length > 14
      title = title.substring(0, 14) + "…"
    content += "<span class='title'>#{title}</span>"
    content += "<br/><span class='length'>#{walk.length}</span>"
    content += "</div>"
    content += "</div>"
    content += "</a>"
