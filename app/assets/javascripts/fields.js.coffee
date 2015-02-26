# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$(document).on 'page:change', ->
  window.map = L.map('map',
   {editable: true}
  ).setView([35.52086, -5.679523], 6)
  L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
    maxZoom: 18,
    id: 'examples.map-20v6611k'
  }).addTo(map)

