# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$(document).on 'page:change', ->
	
  window.mapPaneBg = L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', { maxZoom: 18,id: 'examples.map-20v6611k' })

  window.getShapes = (drawnItems) ->
    shapes = []
    drawnItems.eachLayer (layer) ->
      if layer instanceof L.Polyline
        shapes.push layer.getLatLngs()
      if layer instanceof L.Circle
        shapes.push [ layer.getLatLng() ]
      if layer instanceof L.Marker
        shapes.push [ layer.getLatLng() ]
      return
    shapes

