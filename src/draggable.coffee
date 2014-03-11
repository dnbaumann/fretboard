React = require 'react'
$ = require 'jquery'

Draggable = ({useX, useY, minX, maxX}) ->
    getDefaultProps: ->
        initialPos: {x: 270, y: 141}

    getInitialState: ->
        pos: @props.initialPos
        dragging: false
        rel: null

    componentDidUpdate: (props, state) ->
        if @state.dragging and not state.dragging
            document.addEventListener 'mousemove', @onMouseMove
            document.addEventListener 'mouseup', @onMouseUp
        else unless @state.dragging and state.dragging
            document.removeEventListener 'mousemove', @onMouseMove
            document.removeEventListener 'mouseup', @onMouseUp

    onMouseDown: (e) ->
        return if e.button isnt 0
        pos = $(@getDOMNode()).offset()

        rel = {}
        newX = e.pageX
        {minX, maxX} = @props
        if useX and newX >= minX and newX <= maxX
            rel.x = e.pageX - pos.left
        else if newX <= minX
            rel.x = minX

        @setState {dragging: true, rel}
        e.stopPropagation()
        e.preventDefault()

    onMouseUp: (e) ->
        @setState {dragging: false}
        e.stopPropagation()
        e.preventDefault()

    onMouseMove: (e) ->
        return unless @state.dragging

        pos = {}
        newX = e.pageX - @state.rel.x
        {minX, maxX} = @props
        if useX and newX >= minX and newX <= maxX
            pos.x = newX
            @props.onXChange?(pos.x)
        else if newX <= minX
            pos.x = minX
            @props.onXChange?(pos.x)

        @setState {pos}
        e.stopPropagation()
        e.preventDefault()

module.exports = Draggable