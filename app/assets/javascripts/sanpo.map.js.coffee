if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.Map
  options:
    centerLat: 0
    centerLng: 0
    zoomLevel: 12

  constructor: ->
    @setZoomButtonsHandlers()

  initMap: ->
    centerPoint = new google.maps.LatLng(@options.centerLat, @options.centerLng)
    mapOptions =
      zoom: @options.zoomLevel
      center: centerPoint
      mapTypeId: google.maps.MapTypeId.ROADMAP
      panControl: false
      scrollwheel: false
      streetViewControl: false
      zoomControl: false
    @gmap = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)

  setZoomButtonsHandlers: ->
    $('.map_zoom_controls .zoomIn').click (event) =>
      unless $('.map_zoom_controls .zoomIn').hasClass('limitReached')
        newZoom = @gmap.getZoom() + 1
        @gmap.setZoom(newZoom)
        @checkIfZoomedToExtremes(newZoom)
      event.stopPropagation()
      event.preventDefault()
    $('.map_zoom_controls .zoomOut').click (event) =>
      unless $('.map_zoom_controls .zoomOut').hasClass('limitReached')
        newZoom = @gmap.getZoom() - 1
        @gmap.setZoom(newZoom)
        @checkIfZoomedToExtremes(newZoom)
      event.stopPropagation()
      event.preventDefault()

  checkIfZoomedToExtremes: (zoomLevel) ->
    $('.map_zoom_controls a').removeClass('limitReached')
    if zoomLevel == 0
      $('.map_zoom_controls .zoomOut').addClass('limitReached')
    else if zoomLevel == 21
      $('.map_zoom_controls .zoomIn').addClass('limitReached')

  geolocateAndCenterMap: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(
        (position) =>
          coords = position.coords || position.coordinate || position
          # console.log("Successfully geolocated! #{coords.latitude}x#{coords.longitude}")
          latLng = new google.maps.LatLng(coords.latitude, coords.longitude)
          @gmap.setCenter(latLng)
          @gmap.setZoom(@gmap.getZoom() + 2) # This is completely arbitrary
        , (error) ->
          switch error.code
            when error.TIMEOUT then console.log("geolocation: Timeout")
            when error.POSITION_UNAVAILABLE then console.log("geolocation: Position unavailable")
            when error.PERMISSION_DENIED then console.log("geolocation: Permission denied")
            when error.UNKNOWN_ERROR then console.log("geolocation: Unknown error")
        , {timeout:5000}
      )
