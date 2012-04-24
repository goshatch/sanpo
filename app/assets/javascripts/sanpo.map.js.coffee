if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.Map
  constructor: ->
    console.log "super called!"
    $('.map_zoom_controls .zoomIn').click (event) =>
      event.stopPropagation()
      event.preventDefault()
      @gmap.setZoom(@gmap.getZoom() + 1)
    $('.map_zoom_controls .zoomOut').click (event) =>
      event.stopPropagation()
      event.preventDefault()
      @gmap.setZoom(@gmap.getZoom() - 1)
