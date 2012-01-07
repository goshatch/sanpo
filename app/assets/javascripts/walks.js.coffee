# This creates and initializes a walk map, as well as provides
# functions to add and edit waypoints

class window.SanpoMap
  constructor: (centerLat, centerLng, @waypoints = [], @edit_mode = false) ->
    @center_point = new google.maps.LatLng(centerLat, centerLng)
    options =
      zoom: 17
      center: @center_point
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

    google.maps.event.addListener(@map, 'click', @mapClickHandler)

    # if a path already exists, build it here
    if @waypoints.length > 0
      @addLatLngToPath(new google.maps.LatLng(waypoint.lat, waypoint.lon)) for waypoint in @waypoints

  mapClickHandler: (event) =>
    @addLatLngToPath(event.latLng)

  addLatLngToPath: (latLng) ->
    console.log "Adding waypoint to path at #{latLng.toString()}"
    path = @poly.getPath()
    path.push(latLng)

    marker = new google.maps.Marker(
      position: event.latLng
      title: '#' + path.getLength()
      map: @map
    )
