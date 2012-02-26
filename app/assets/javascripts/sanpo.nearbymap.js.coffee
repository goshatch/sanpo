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
    @addWalkMarkers()

  addWalkMarkers: ->
    url = "/walks.json"
    if @options.search
      url = "#{url}?search=#{@options.search}"
    console.log "Ajax url: #{url}"
    $.getJSON(url, (walks) =>
      for walk in walks
        vertex = new google.maps.LatLng(walk.latitude, walk.longitude)
        marker = new google.maps.Marker(
          map: @gmap
          position: vertex
          title: walk.title
        )
        @bounds.extend(vertex)
        @gmap.fitBounds(@bounds)
    )
