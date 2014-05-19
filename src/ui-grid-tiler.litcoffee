#ui-grid-tiler
This is a space filling element that resists scrolling by making its child
elements evenly sized. By default this is centered, so that if you have
`inline-block` children, it will form as close to a Brady Bunch style grid as
possible.

This sets the width, but constraints the max height. This works well with forced
aspect ration tags like `video`.

    _ = require 'lodash'

##Events

    Polymer 'ui-grid-tiler',

##Attributes and Change Handlers

###startPercentage
Start and this percentage and step down from there in order to tile. This is
a whole number like `100` (the default) or 50.

##Methods

Resize the children to prevent any scrolling.

      resize: ->
        width = @startPercentage or 100
        children = @children
        _.each children, (tile) =>
          tile.style['width'] = "#{width}%"
          tile.style['max-height'] = "#{width}%"
        stepDown = =>
          if ((@scrollHeight <= @clientHeight) and (@scrollWidth <= @clientWidth)) or width is 1
            return
          else
            _.each children, (tile) =>
              tile.style['width'] = "#{width}%"
              tile.style['max-height'] = "#{width}%"
            width -= 1
            setTimeout stepDown, 5
        setTimeout stepDown, 10

##Event Handlers

      windowResize: ->
        @resize()

      childrenMutated: ->
        @resize()
        @onMutation @, =>
          @childrenMutated()

##Polymer Lifecycle

Hard binding here to be used from the window event handler. Keeping your `@`
straight can be a nuisance...

      created: ->
        @windowResize = @windowResize.bind(@)

      ready: ->

      attached: ->
        window.addEventListener 'resize', =>
          @resize()
        @onMutation @, =>
          @childrenMutated()

      domReady: ->

      detached: ->
