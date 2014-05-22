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

###startPercentage
Start and this percentage and step down from there in order to tile. This is
a whole number like `100` (the default) or 50.

###gridMargin
Use this to separate grid tiles. Defaults to 1%.

##Methods

Resize the children to prevent any scrolling.

      resize: ->
        children = @children
        width = Math.min(@clientWidth, @clientHeight) / Math.floor(Math.sqrt(children.length))
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
        @resize()
        @onMutation @, =>
          @childrenMutated()

      domReady: ->

      detached: ->
