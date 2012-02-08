# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#uploadPhoto').modal({
    backdrop: true,
    keyboard: true
  })
  $('.best_in_place').best_in_place()
  $('form#new_walk').submit (event) ->
    success = map.saveUpdatedPath()
    if success != 1
      event.stopPropagation()
      event.preventDefault()
      console.log "Failed to save route"
