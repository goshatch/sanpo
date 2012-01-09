# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('form#new_walk').submit (event) ->
    success = map.saveUpdatedPath()
    if success == 1
      console.log('successsss!')
    else
      console.log('frownyface')
      event.stopPropagation()
      event.preventDefault()
