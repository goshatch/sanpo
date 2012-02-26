if !window.Sanpo
  window.Sanpo = {}

window.Sanpo.geolocateAndCenterMap = (map) ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(
      (position) ->
        coords = position.coords || position.coordinate || position
        console.log("Successfully geolocated! #{coords.latitude}x#{coords.longitude}")
        latLng = new google.maps.LatLng(coords.latitude, coords.longitude)
        map.setCenter(latLng)
      , (error) ->
        switch error.code
          when error.TIMEOUT then console.log("geolocation: Timeout")
          when error.POSITION_UNAVAILABLE then console.log("geolocation: Position unavailable")
          when error.PERMISSION_DENIED then console.log("geolocation: Permission denied")
          when error.UNKNOWN_ERROR then console.log("geolocation: Unknown error")
      , {timeout:5000}
    )
