# This handles the geocoding search field for Sanpo maps.
if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.MapSearchField
  options:
    placeholder: "Where did you go?"
    buttonText: "Show it to me"
    cssClass: null

  constructor: (gmap, options) ->
    if options
      if options.placeholder != undefined
        @options.placeholder = options.placeholder
      if options.buttonText
        @options.buttonText = options.buttonText
      if options.cssClass != undefined
        @options.cssClass = options.cssClass

    @gmap = gmap
    @geocoder = new google.maps.Geocoder();
    if @options.cssClass
      $("#mapSearchField").addClass(@options.cssClass)
    $("#mapLocationSearchForm .searchField").attr("placeholder", @options.placeholder)
    $("#mapLocationSearchForm .submitButton").val(@options.buttonText)
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
          @gmap.setCenter(results[0].geometry.location)
          @gmap.setZoom(15)
        else
          alert("Couldn't locate that place: " + status);
    )
