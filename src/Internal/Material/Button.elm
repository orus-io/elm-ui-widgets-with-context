module Internal.Material.Button exposing (baseButton, containedButton, iconButton, outlinedButton, textButton, toggleButton)

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Html.Attributes as Attributes
import Internal.Button exposing (ButtonStyle)
import Internal.Material.Palette as Palette exposing (Palette)
import Widget.Material.Color as MaterialColor
import Widget.Material.Context exposing (..)
import Widget.Material.Typography as Typography


baseButton : ButtonStyle context (Theme theme) msg
baseButton =
    { elementButton =
        Typography.button
            ++ [ Element.height <| Element.px 36
               , Element.paddingXY 8 8
               , Border.rounded <| 4
               ]
    , ifDisabled =
        [ Element.htmlAttribute <| Attributes.style "cursor" "not-allowed"
        ]
    , ifActive = []
    , otherwise = []
    , content =
        { elementRow =
            [ Element.spacing <| 8
            , Element.width <| Element.minimum 32 <| Element.shrink
            , Element.centerY
            ]
        , content =
            { text = { contentText = [ Element.centerX ] }
            , icon =
                { ifDisabled =
                    { size = 18
                    , color = getPalette >> Palette.gray
                    }
                , ifActive =
                    { size = 18
                    , color = getPalette >> Palette.gray
                    }
                , otherwise =
                    { size = 18
                    , color = getPalette >> Palette.gray
                    }
                }
            }
        }
    }


{-| A contained button representing the most important action of a group.
-}
containedButton : ButtonStyle context (Theme theme) msg
containedButton =
    { elementButton =
        (baseButton |> .elementButton)
            ++ [ Border.shadow <| MaterialColor.shadow 2
               , Element.mouseDown <|
                    [ withPaletteDecoration
                        (\palette ->
                            palette.primary
                                |> MaterialColor.withShade palette.on.primary MaterialColor.buttonPressedOpacity
                                |> MaterialColor.fromColor
                        )
                        Background.color
                    , Border.shadow <| MaterialColor.shadow 12
                    ]
               , Element.focused <|
                    [ withPaletteDecoration
                        (\palette ->
                            palette.primary
                                |> MaterialColor.withShade palette.on.primary MaterialColor.buttonFocusOpacity
                                |> MaterialColor.fromColor
                        )
                        Background.color
                    , Border.shadow <| MaterialColor.shadow 6
                    ]
               , Element.mouseOver <|
                    [ withPaletteDecoration
                        (\palette ->
                            palette.primary
                                |> MaterialColor.withShade palette.on.primary MaterialColor.buttonHoverOpacity
                                |> MaterialColor.fromColor
                        )
                        Background.color
                    , Border.shadow <| MaterialColor.shadow 6
                    ]
               ]
    , ifDisabled =
        (baseButton |> .ifDisabled)
            ++ [ Background.color
                    |> withPaletteAttribute
                        (Palette.gray
                            >> MaterialColor.scaleOpacity MaterialColor.buttonDisabledOpacity
                            >> MaterialColor.fromColor
                        )
               , Font.color
                    |> withPaletteAttribute
                        (Palette.gray >> MaterialColor.fromColor)
               , Border.shadow <| MaterialColor.shadow 0
               , Element.mouseDown []
               , Element.mouseOver []
               , Element.focused []
               ]
    , ifActive =
        [ Background.color
            |> withPaletteAttribute
                (\palette ->
                    palette.primary
                        |> MaterialColor.withShade palette.on.primary MaterialColor.buttonHoverOpacity
                        |> MaterialColor.fromColor
                )
        , Font.color
            |> withPrimaryAttribute
                (MaterialColor.accessibleTextColor
                    >> MaterialColor.fromColor
                )
        ]
    , otherwise =
        [ Background.color
            |> withPrimaryAttribute
                MaterialColor.fromColor
        , Font.color
            |> withPrimaryAttribute
                (MaterialColor.accessibleTextColor
                    >> MaterialColor.fromColor
                )
        ]
    , content =
        { elementRow =
            (baseButton |> .content |> .elementRow)
                ++ [ Element.paddingXY 8 0 ]
        , content =
            { text = { contentText = baseButton |> (\b -> b.content.content.text.contentText) }
            , icon =
                { ifActive =
                    { size = 18
                    , color =
                        getPrimaryColor
                            >> MaterialColor.accessibleTextColor
                    }
                , ifDisabled =
                    { size = 18
                    , color =
                        getPalette
                            >> Palette.gray
                    }
                , otherwise =
                    { size = 18
                    , color =
                        getPrimaryColor
                            >> MaterialColor.accessibleTextColor
                    }
                }
            }
        }
    }


{-| A outlined button representing an important action within a group.
-}
outlinedButton : ButtonStyle context (Theme theme) msg
outlinedButton =
    { elementButton =
        (baseButton |> .elementButton)
            ++ [ Border.width <| 1
               , Font.color
                    |> withPrimaryAttribute
                        MaterialColor.fromColor
               , Border.color
                    |> withPaletteAttribute
                        (\palette ->
                            palette.on.surface
                                |> MaterialColor.scaleOpacity 0.14
                                |> MaterialColor.withShade palette.primary MaterialColor.buttonHoverOpacity
                                |> MaterialColor.fromColor
                        )
               , Element.mouseDown
                    [ Background.color
                        |> withPrimaryDecoration
                            (MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                                >> MaterialColor.fromColor
                            )
                    ]
               , Element.focused
                    [ Background.color
                        |> withPrimaryDecoration
                            (MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                                >> MaterialColor.fromColor
                            )
                    ]
               , Element.mouseOver
                    [ Background.color
                        |> withPrimaryDecoration
                            (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                                >> MaterialColor.fromColor
                            )
                    ]
               ]
    , ifDisabled =
        (baseButton |> .ifDisabled)
            ++ [ Font.color
                    |> withPaletteAttribute
                        (Palette.gray
                            >> MaterialColor.fromColor
                        )
               , Element.mouseDown []
               , Element.mouseOver []
               , Element.focused []
               ]
    , ifActive =
        [ Background.color
            |> withPrimaryAttribute
                (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                    >> MaterialColor.fromColor
                )
        ]
    , otherwise =
        []
    , content =
        { elementRow =
            (baseButton
                |> .content
                |> .elementRow
            )
                ++ [ Element.paddingXY 8 0 ]
        , content =
            { text =
                { contentText =
                    baseButton
                        |> .content
                        |> .content
                        |> .text
                        |> .contentText
                }
            , icon =
                { ifActive =
                    { size = 18
                    , color = getPrimaryColor
                    }
                , ifDisabled =
                    { size = 18
                    , color = getPalette >> Palette.gray
                    }
                , otherwise =
                    { size = 18
                    , color = getPrimaryColor
                    }
                }
            }
        }
    }


{-| A text button representing a simple action within a group.
-}
textButton : ButtonStyle context (Theme theme) msg
textButton =
    { elementButton =
        (baseButton |> .elementButton)
            ++ [ Font.color
                    |> withPrimaryAttribute
                        MaterialColor.fromColor
               , Element.mouseDown
                    [ Background.color
                        |> withPrimaryDecoration
                            (MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                                >> MaterialColor.fromColor
                            )
                    ]
               , Element.focused
                    [ Background.color
                        |> withPrimaryDecoration
                            (MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                                >> MaterialColor.fromColor
                            )
                    ]
               , Element.mouseOver
                    [ Background.color
                        |> withPrimaryDecoration
                            (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                                >> MaterialColor.fromColor
                            )
                    ]
               ]
    , ifDisabled =
        (baseButton |> .ifDisabled)
            ++ [ Font.color
                    |> withPaletteAttribute
                        (Palette.gray
                            >> MaterialColor.fromColor
                        )
               , Element.mouseDown []
               , Element.mouseOver []
               , Element.focused []
               ]
    , ifActive =
        [ Background.color
            |> withPrimaryAttribute
                (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                    >> MaterialColor.fromColor
                )
        ]
    , otherwise =
        []
    , content =
        { elementRow = baseButton |> (\b -> b.content.elementRow)
        , content =
            { text = { contentText = baseButton |> (\b -> b.content.content.text.contentText) }
            , icon =
                { ifActive =
                    { size = 18
                    , color = getPrimaryColor
                    }
                , ifDisabled =
                    { size = 18
                    , color = getPalette >> Palette.gray
                    }
                , otherwise =
                    { size = 18
                    , color = getPrimaryColor
                    }
                }
            }
        }
    }


{-| A ToggleButton. Only use as a group in combination with `buttonRow`.

Toggle buttons should only be used with the `iconButton` widget, else use chips instead.

Technical Remark:

  - Border color was not defined in the [specification](https://material.io/components/buttons#toggle-button)
  - There are two different versions, one where the selected color is gray and another where the color is primary.
    I noticed the gray version was used more often, so i went with that one.

-}
toggleButton : ButtonStyle context (Theme theme) msg
toggleButton =
    { elementButton =
        Typography.button
            ++ [ Element.width <| Element.px 48
               , Element.height <| Element.px 48
               , Element.padding 4
               , Border.width <| 1
               , Element.mouseDown <|
                    [ Background.color
                        |> withPaletteDecoration
                            (\palette ->
                                palette.surface
                                    |> MaterialColor.withShade palette.on.surface MaterialColor.buttonPressedOpacity
                                    |> MaterialColor.fromColor
                            )
                    , Border.color
                        |> withPaletteDecoration
                            (\palette ->
                                palette.on.surface
                                    |> MaterialColor.scaleOpacity 0.14
                                    |> MaterialColor.withShade palette.on.surface MaterialColor.buttonPressedOpacity
                                    |> MaterialColor.fromColor
                            )
                    ]
               , Element.focused []
               , Element.mouseOver <|
                    [ Background.color
                        |> withPaletteDecoration
                            (\palette ->
                                palette.surface
                                    |> MaterialColor.withShade palette.on.surface MaterialColor.buttonHoverOpacity
                                    |> MaterialColor.fromColor
                            )
                    , Border.color
                        |> withPaletteDecoration
                            (\palette ->
                                palette.on.surface
                                    |> MaterialColor.scaleOpacity 0.14
                                    |> MaterialColor.withShade palette.on.surface MaterialColor.buttonHoverOpacity
                                    |> MaterialColor.fromColor
                            )
                    ]
               ]
    , ifDisabled =
        (baseButton |> .ifDisabled)
            ++ [ Background.color
                    |> withSurfaceAttribute MaterialColor.fromColor
               , Border.color
                    |> withOnSurfaceAttribute
                        (MaterialColor.scaleOpacity 0.14
                            >> MaterialColor.fromColor
                        )
               , withPaletteAttribute
                    (Palette.gray
                        >> MaterialColor.fromColor
                    )
                    Font.color
               , Element.mouseDown []
               , Element.mouseOver []
               ]
    , ifActive =
        [ Background.color
            |> withPaletteAttribute
                (\palette ->
                    palette.surface
                        |> MaterialColor.withShade palette.on.surface MaterialColor.buttonSelectedOpacity
                        |> MaterialColor.fromColor
                )
        , Font.color
            |> withSurfaceAttribute
                (MaterialColor.accessibleTextColor
                    >> MaterialColor.fromColor
                )
        , Border.color
            |> withPaletteAttribute
                (\palette ->
                    palette.on.surface
                        |> MaterialColor.scaleOpacity 0.14
                        |> MaterialColor.withShade palette.on.surface MaterialColor.buttonSelectedOpacity
                        |> MaterialColor.fromColor
                )
        , Element.mouseOver []
        ]
    , otherwise =
        [ Background.color
            |> withSurfaceAttribute
                MaterialColor.fromColor
        , Font.color
            |> withSurfaceAttribute
                (MaterialColor.accessibleTextColor
                    >> MaterialColor.fromColor
                )
        , Border.color
            |> withOnSurfaceAttribute
                (MaterialColor.scaleOpacity 0.14
                    >> MaterialColor.fromColor
                )
        ]
    , content =
        { elementRow =
            [ Element.spacing <| 8
            , Element.height Element.fill
            , Element.width Element.fill
            , Border.rounded 24
            , Element.padding 8
            , Element.focused <|
                MaterialColor.textAndBackgroundDecoration
                    (\{ theme } ->
                        theme.material.surface
                            |> MaterialColor.withShade theme.material.on.surface MaterialColor.buttonFocusOpacity
                    )
            ]
        , content =
            { text = { contentText = [ Element.centerX ] }
            , icon =
                { ifActive =
                    { size = 24
                    , color =
                        getSurfaceColor
                            >> MaterialColor.accessibleTextColor
                    }
                , ifDisabled =
                    { size = 24
                    , color = getPalette >> Palette.gray
                    }
                , otherwise =
                    { size = 24
                    , color =
                        getSurfaceColor
                            >> MaterialColor.accessibleTextColor
                    }
                }
            }
        }
    }


{-| An single selectable icon.

Technical Remark:

  - Could not find any specification details

-}
iconButton : ButtonStyle context (Theme theme) msg
iconButton =
    { elementButton =
        (baseButton |> .elementButton)
            ++ [ Element.height <| Element.px 48
               , Element.width <| Element.minimum 48 <| Element.shrink
               , Border.rounded 24
               , Element.mouseDown
                    [ withSurfaceDecoration
                        (MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                            >> MaterialColor.fromColor
                        )
                        Background.color
                    ]
               , Element.focused
                    [ withSurfaceDecoration
                        (MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                            >> MaterialColor.fromColor
                        )
                        Background.color
                    ]
               , Element.mouseOver
                    [ withSurfaceDecoration
                        (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                            >> MaterialColor.fromColor
                        )
                        Background.color
                    ]
               ]
    , ifDisabled =
        (baseButton |> .ifDisabled)
            ++ [ withPaletteAttribute
                    (Palette.gray
                        >> MaterialColor.fromColor
                    )
                    Font.color
               , Element.mouseDown []
               , Element.mouseOver []
               , Element.focused []
               ]
    , ifActive =
        [ withSurfaceAttribute
            (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                >> MaterialColor.fromColor
            )
            Background.color
        ]
    , otherwise =
        []
    , content =
        { elementRow =
            [ Element.spacing 8
            , Element.width <| Element.shrink
            , Element.centerY
            , Element.centerX
            ]
        , content =
            { text = { contentText = [ Element.centerX ] }
            , icon =
                { ifActive =
                    { size = 18
                    , color = getPrimaryColor
                    }
                , ifDisabled =
                    { size = 18
                    , color = getPalette >> Palette.gray
                    }
                , otherwise =
                    { size = 18
                    , color = getPrimaryColor
                    }
                }
            }
        }
    }
