if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.NearbyWalksMap
  options:
    centerLat: 0
    centerLng: 0
    zoomLevel: 2
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
    @gmap = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)
    @bounds = new google.maps.LatLngBounds()
    @addWalkMarkersToMap()

  addWalkMarkersToMap: ->
    url = "/walks.json"
    if @options.search
      url = "#{url}?search=#{@options.search}"
    console.log "Ajax url: #{url}"
    $.getJSON(url, (walks) =>
      @createInfoBubble(walk) for walk in walks
    )
    @gmap.fitBounds(@bounds)

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
      borderWidth: 3
      borderRadius: 10
      hideCloseButton: true
      content: @infoBubbleContentForWalk(walk)
    )
    infoBubble.open()
    @bounds.extend(vertex)

  # Generates the content for the walk's infobubble (icon, description, link).
  # The walk must come from the JSON list as defined in addWalkMarkersToMap
  infoBubbleContentForWalk: (walk) ->
    content = "<div class='walkInfoBubble' id='walkInfoBubble_#{walk.id}'>"
    content += "<a href='/walks/#{walk.id}' title='#{walk.title}'>"
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
