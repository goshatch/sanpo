if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.Map
  constructor: ->
    @setZoomButtonsHandlers()

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

