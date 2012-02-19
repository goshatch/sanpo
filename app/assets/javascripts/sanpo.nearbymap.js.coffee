if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.NearbyWalksMap
  options:
    centerLat: 0
    centerLng: 0
    zoomLevel: 2

  constructor: (options) ->
    if options
      if options.centerLat != undefined
        @options.centerLat = options.centerLat
      if options.centerLng != undefined
        @options.centerLng = options.centerLng
      if options.zoomLevel != undefined
        @options.zoomLevel = options.zoomLevel

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
