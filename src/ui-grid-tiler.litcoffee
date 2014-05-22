#ui-grid-tiler
This is a space filling element that resists scrolling by making its child
elements evenly sized. By default this is centered, so that if you have
`inline-block` children, it will form as close to a Brady Bunch style grid as
possible.

This sets the width, but constraints the max height. This works well with forced
aspect ration tags like `video`.

    _ = require 'lodash'
    ResizeSensor = require './ResizeSensor'

##Events

    Polymer 'ui-grid-tiler',

##Attributes and Change Handlers

###aspectRatio
This acts as a multiplier on width. Default is 1.

##Methods

Resize the children to prevent any scrolling.

      resize: ->
        children = @children
        core = Math.min(@clientWidth, @clientHeight) / Math.floor(Math.sqrt(children.length))
        width = Number(@aspectRatio or 1) * core
        height = width
        _.each children, (tile) =>
          tile.style['width'] = "#{width}px"
          tile.style['max-height'] = "#{width}px"

##Event Handlers

      childrenMutated: ->
        @resize()
        @onMutation @, =>
          @childrenMutated()

##Polymer Lifecycle

      created: ->

      ready: ->

      attached: ->
        @sensor = new ResizeSensor @, =>
          @resize()
        window.addEventListener 'resize', =>
          @resize()
        @resize()
        @onMutation @, =>
          @childrenMutated()

      domReady: ->

      detached: ->
