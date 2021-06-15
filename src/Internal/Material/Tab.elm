module Internal.Material.Tab exposing (tab, tabButton)

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Internal.Button exposing (ButtonStyle)
import Internal.Context exposing (Context)
import Internal.Material.Button as Button
import Internal.Material.Palette as Palette exposing (Palette)
import Internal.Tab exposing (TabStyle)
import Widget.Material.Color as MaterialColor
import Widget.Material.Typography as Typography


tabButton : ButtonStyle context Palette msg
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
                    |> Element.withAttribute
                        (\{ theme } ->
                            theme.primary
                                |> MaterialColor.fromColor
                        )
               , Element.mouseDown
                    [ Background.color
                        |> Element.withDecoration
                            (\{ theme } ->
                                theme.primary
                                    |> MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                                    |> MaterialColor.fromColor
                            )
                    ]
               , Element.focused
                    [ Background.color
                        |> Element.withDecoration
                            (\{ theme } ->
                                theme.primary
                                    |> MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                                    |> MaterialColor.fromColor
                            )
                    ]
               , Element.mouseOver
                    [ Background.color
                        |> Element.withDecoration
                            (\{ theme } ->
                                theme.primary
                                    |> MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                                    |> MaterialColor.fromColor
                            )
                    ]
               ]
    , ifDisabled =
        (Button.baseButton |> .ifDisabled)
            ++ [ Font.color
                    |> Element.withAttribute
                        (\{ theme } ->
                            Palette.gray theme
                                |> MaterialColor.fromColor
                        )
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
                    , color = .primary
                    }
                , ifDisabled =
                    { size = 18
                    , color = Palette.gray
                    }
                , otherwise =
                    { size = 18
                    , color = .primary
                    }
                }
            }
        }
    }


tab : TabStyle context Palette msg
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
