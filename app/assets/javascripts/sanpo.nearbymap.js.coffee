if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.NearbyWalksMap extends window.Sanpo.Map
  _options:
    search: null

  constructor: (options) ->
    $.extend(@options, @_options)
    $.extend(@options, options)

    @initMap()

    @addWalkMarkersToMap()
    geocoderOptions =
      placeholder: "Where do you want to go?"
      cssClass: "large"
      buttonText: "Search"
    @geocoder = new Sanpo.MapSearchField(@gmap, geocoderOptions)

    @geolocateAndCenterMap()

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
