module Internal.Material.AppBar exposing (menuBar, tabBar)

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Internal.AppBar exposing (AppBarStyle)
import Internal.Button exposing (ButtonStyle)
import Internal.Context exposing (Attribute)
import Internal.Material.Button as Button
import Widget.Material.Context exposing (..)
import Internal.Material.Icon as Icon
import Internal.Material.Palette as Palette exposing (Palette)
import Internal.Material.TextInput as TextInput
import Widget.Customize as Customize
import Widget.Icon as Icon exposing (Icon)
import Widget.Material.Color as MaterialColor
import Widget.Material.Typography as Typography


menuTabButton : ButtonStyle context Theme msg
menuTabButton =
    { elementButton =
        Typography.button
            ++ [ Element.height <| Element.px 56
               , Element.fill
                    |> Element.maximum 360
                    |> Element.minimum 90
                    |> Element.width
               , Element.paddingXY 12 16
               , withPrimaryAttribute
                    (MaterialColor.accessibleTextColor
                        >> MaterialColor.fromColor
                    )
                    Font.color
               , Element.alignBottom
               , Element.mouseDown
                    [ withPrimaryDecoration
                        (MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                            >> MaterialColor.fromColor
                        )
                        Background.color
                    ]
               , Element.focused
                    [ withPrimaryDecoration
                        (MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                            >> MaterialColor.fromColor
                        )
                        Background.color
                    ]
               , Element.mouseOver
                    [ withPrimaryDecoration
                        (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                            >> MaterialColor.fromColor
                        )
                        Background.color
                    ]
               ]
    , ifDisabled =
        (Button.baseButton |> .ifDisabled)
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
        [ Border.widthEach
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
                    , color = .primary >> MaterialColor.accessibleTextColor
                    }
                , ifDisabled =
                    { size = 18
                    , color = Palette.gray
                    }
                , otherwise =
                    { size = 18
                    , color = .primary >> MaterialColor.accessibleTextColor
                    }
                }
            }
        }
    }


menuBar :
    AppBarStyle
        { menuIcon : Icon context Theme msg
        , title : List (Attribute context Theme msg)
        }
        context
        Theme
        msg
menuBar =
    internalBar
        { menuIcon = Icon.menu
        , title = Typography.h6 ++ [ Element.paddingXY 8 0 ]
        }


tabBar :
    AppBarStyle
        { menuTabButton : ButtonStyle context Theme msg
        , title : List (Attribute context Theme msg)
        }
        context
        Theme
        msg
tabBar =
    internalBar
        { menuTabButton = menuTabButton
        , title = Typography.h6 ++ [ Element.paddingXY 8 0 ]
        }


internalBar : content -> AppBarStyle content context Theme msg
internalBar content =
    { elementRow =
        (getPrimaryColor
            |> MaterialColor.textAndBackground
        )
            ++ [ Element.padding 0
               , Element.spacing 8
               , Element.height <| Element.px 56
               , Element.width <| Element.minimum 360 <| Element.fill
               ]
    , content =
        { menu =
            { elementRow =
                [ Element.width <| Element.shrink
                , Element.spacing 8
                ]
            , content = content
            }
        , search = TextInput.searchInput
        , actions =
            { elementRow =
                [ Element.alignRight
                , Element.width Element.shrink
                ]
            , content =
                { button =
                    Button.iconButton
                        |> Customize.mapContent
                            (Customize.mapContent
                                (\record ->
                                    { record
                                        | icon =
                                            { ifActive =
                                                { size = record.icon.ifActive.size
                                                , color =
                                                    .primary
                                                        >> MaterialColor.accessibleTextColor
                                                }
                                            , ifDisabled =
                                                record.icon.ifDisabled
                                            , otherwise =
                                                { size = record.icon.otherwise.size
                                                , color =
                                                    .primary
                                                        >> MaterialColor.accessibleTextColor
                                                }
                                            }
                                    }
                                )
                            )
                , searchIcon = Icon.search
                , moreVerticalIcon = Icon.more_vert
                }
            }
        }
    }
