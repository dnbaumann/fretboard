{Guitar} = require 'fretboard'
{Dropdown} = require 'toolbox'
React = require 'react'
{div, button} = React.DOM
scalesData = require 'scales'

notesOptions = ([k, k] for k, v of scalesData)
scalesOptions = [["Minor", "Minor"], ["Major", "Major"]]

Note = "C"
Scale = "Minor"

guitarInstance = Guitar {fretWidth: 40, fretHeight: 30}
React.renderComponent guitarInstance, document.getElementById "container"

handleChangeNote = ({value}) ->
    Note = value
    guitarInstance.pressStringFrets scalesData[Note][Scale]

handleChangeScale = ({value}) ->
    Scale = value
    guitarInstance.pressStringFrets scalesData[Note][Scale]

React.renderComponent(
    (div {},
        (Dropdown {data: {options: notesOptions}, onChange: handleChangeNote})
        (Dropdown {data: {options: scalesOptions}, onChange: handleChangeScale})
        (button {value: "play", onClick: guitarInstance.playScale}, "play")
    )
    document.getElementById "toolbar"
)

guitarInstance.pressStringFrets scalesData[Note][Scale]