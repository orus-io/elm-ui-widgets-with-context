module Internal.Material.Tab exposing (tab, tabButton)

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Internal.Button exposing (ButtonStyle)
import Internal.Material.Button as Button
import Internal.Material.Palette as Palette exposing (Palette)
import Internal.Tab exposing (TabStyle)
import Widget.Material.Color as MaterialColor
import Widget.Material.Context exposing (..)
import Widget.Material.Typography as Typography


tabButton : ButtonStyle (Context context) msg
tabButton =
    { elementButton =
        Typography.button
            ++ [ Element.height <| Element.px 48
               , Element.fill
                    |> Element.maximum 360
                    |> Element.minimum 90
                    |> Element.width
               , Element.paddingXY 12 16
               , Font.color
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
        (Button.baseButton |> .ifDisabled)
            ++ [ Font.color
                    |> withPaletteAttribute
                        (Palette.gray >> MaterialColor.fromColor)
               , Element.mouseDown []
               , Element.mouseOver []
               , Element.focused []
               ]
    , ifActive =
        [ Element.height <| Element.px 48
        , Border.widthEach
            { bottom = 2
            , left = 0
            , right = 0
            , top = 0
            }
        ]
    , otherwise =
        []
    , content =
        { elementRow =
            [ Element.spacing <| 8
            , Element.centerY
            , Element.centerX
            ]
        , content =
            { text = { contentText = [] }
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


tab : TabStyle (Context context) msg
tab =
    { elementColumn = [ Element.spacing 8, Element.width <| Element.fill ]
    , content =
        { tabs =
            { elementRow =
                [ Element.spaceEvenly
                , Border.shadow <| MaterialColor.shadow 4
                , Element.spacing 8
                , Element.width <| Element.fill
                ]
            , content = tabButton
            }
        , content = [ Element.width <| Element.fill ]
        }
    }
