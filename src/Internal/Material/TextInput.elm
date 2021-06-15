module Internal.Material.TextInput exposing (searchInput, textInput, textInputBase)

import Element.WithContext as Element
import Element.WithContext.Border as Border
import Internal.Context exposing (Context)
import Internal.Material.Chip as Chip
import Internal.Material.Context exposing (..)
import Internal.Material.Palette exposing (Palette)
import Internal.TextInput exposing (TextInputStyle)
import Widget.Customize as Customize
import Widget.Material.Color as MaterialColor


textInput : TextInputStyle context Theme msg
textInput =
    { elementRow =
        (getSurfaceColor
            |> MaterialColor.textAndBackground
        )
            ++ [ Element.spacing 8
               , Element.paddingXY 8 0
               , Border.width 1
               , Border.rounded 4
               , withOnSurfaceAttribute
                    (MaterialColor.scaleOpacity 0.14
                        >> MaterialColor.fromColor
                    )
                    Border.color
               , Element.focused
                    [ Border.shadow <| MaterialColor.shadow 4
                    , withPrimaryDecoration
                        MaterialColor.fromColor
                        Border.color
                    ]
               , Element.width <| Element.px <| 280
               , Element.mouseOver [ Border.shadow <| MaterialColor.shadow 2 ]
               ]
    , content =
        { chips =
            { elementRow = [ Element.spacing 8 ]
            , content = Chip.chip
            }
        , text =
            { elementTextInput =
                (getSurfaceColor
                    |> MaterialColor.textAndBackground
                )
                    ++ [ Border.width 0
                       , Element.mouseOver []
                       , Element.focused []
                       , Element.centerY
                       ]
            }
        }
    }


searchInput : TextInputStyle context Theme msg
searchInput =
    textInputBase
        |> Customize.mapElementRow
            (always
                [ Element.alignRight
                , Element.paddingXY 8 8
                , Border.rounded 4
                ]
            )
        |> Customize.mapContent
            (\record ->
                { record
                    | text =
                        record.text
                            |> Customize.elementTextInput
                                [ Border.width 0
                                , Element.paddingXY 8 8
                                , Element.height <| Element.px 32
                                , Element.width <| Element.maximum 360 <| Element.fill
                                ]
                }
            )


textInputBase : TextInputStyle context Theme msg
textInputBase =
    { elementRow =
        getSurfaceColor
            |> MaterialColor.textAndBackground
    , content =
        { chips =
            { elementRow = [ Element.spacing 8 ]
            , content = Chip.chip
            }
        , text =
            { elementTextInput =
                (getSurfaceColor
                    |> MaterialColor.textAndBackground
                )
                    ++ [ Border.width 0
                       , Element.mouseOver []
                       , Element.focused []
                       ]
            }
        }
    }
