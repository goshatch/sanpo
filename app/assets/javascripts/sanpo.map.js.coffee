if !window.Sanpo
  window.Sanpo = {}

class window.Sanpo.Map
  constructor: ->
    $('.map_zoom_controls .zoomIn').click (event) =>
      console.log("Attempting to zoom map")
    $('.map_zoom_controls .zoomOut').click (event) =>
      console.log("Attempting to unzoom map")
