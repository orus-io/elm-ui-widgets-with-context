module Internal.Material.Item exposing
    ( expansionItem
    , fullBleedDivider
    , fullBleedHeader
    , fullBleedItem
    , imageItem
    , insetDivider
    , insetHeader
    , insetItem
    , middleDivider
    , multiLineItem
    , selectItem
    )

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Html.Attributes as Attributes
import Internal.Button exposing (ButtonStyle)
import Internal.Context exposing (Context)
import Internal.Item exposing (DividerStyle, ExpansionItemStyle, FullBleedItemStyle, HeaderStyle, ImageItemStyle, InsetItemStyle, ItemStyle, MultiLineItemStyle)
import Internal.Material.Button as Button
import Internal.Material.Icon as Icon
import Internal.Material.Palette as Palette exposing (Palette)
import Widget.Material.Color as MaterialColor
import Widget.Material.Context exposing (..)
import Widget.Material.Typography as Typography


fullBleedDivider : ItemStyle (DividerStyle context (Theme theme) msg) context (Theme theme) msg
fullBleedDivider =
    { element =
        [ Element.width <| Element.fill
        , Element.height <| Element.px 1
        , Element.padding 0
        , Border.width 0
        ]
    , content =
        { element =
            [ Element.width <| Element.fill
            , Element.height <| Element.px 1
            , withPaletteAttribute
                (Palette.lightGray
                    >> MaterialColor.fromColor
                )
                Background.color
            ]
        }
    }


insetDivider : ItemStyle (DividerStyle context (Theme theme) msg) context (Theme theme) msg
insetDivider =
    { element =
        [ Element.width <| Element.fill
        , Element.height <| Element.px 1
        , Border.width 0
        , Element.paddingEach
            { bottom = 0
            , left = 72
            , right = 0
            , top = 0
            }
        ]
    , content =
        { element =
            [ Element.width <| Element.fill
            , Element.height <| Element.px 1
            , withPaletteAttribute
                (Palette.lightGray
                    >> MaterialColor.fromColor
                )
                Background.color
            ]
        }
    }


middleDivider : ItemStyle (DividerStyle context (Theme theme) msg) context (Theme theme) msg
middleDivider =
    { element =
        [ Element.width <| Element.fill
        , Element.height <| Element.px 1
        , Border.width 0
        , Element.paddingEach
            { bottom = 0
            , left = 16
            , right = 16
            , top = 0
            }
        ]
    , content =
        { element =
            [ Element.width <| Element.fill
            , Element.height <| Element.px 1
            , withPaletteAttribute
                (Palette.lightGray
                    >> MaterialColor.fromColor
                )
                Background.color
            ]
        }
    }


insetHeader : ItemStyle (HeaderStyle context (Theme theme) msg) context (Theme theme) msg
insetHeader =
    { element =
        [ Element.width <| Element.fill
        , Element.height <| Element.shrink
        , Border.width 0
        , Element.paddingEach
            { bottom = 0
            , left = 72
            , right = 0
            , top = 0
            }
        ]
    , content =
        { elementColumn =
            [ Element.width <| Element.fill
            , Element.spacing <| 12
            ]
        , content =
            { divider =
                insetDivider
                    |> .content
            , title =
                Typography.caption
                    ++ [ withPaletteAttribute
                            (Palette.textGray
                                >> MaterialColor.fromColor
                            )
                            Font.color
                       ]
            }
        }
    }


fullBleedHeader : ItemStyle (HeaderStyle context (Theme theme) msg) context (Theme theme) msg
fullBleedHeader =
    { element =
        [ Element.width <| Element.fill
        , Element.height <| Element.shrink
        , Element.padding 0
        , Border.widthEach
            { bottom = 0
            , left = 0
            , right = 0
            , top = 1
            }
        , withPaletteAttribute
            (Palette.lightGray
                >> MaterialColor.fromColor
            )
            Border.color
        ]
    , content =
        { elementColumn =
            [ Element.width <| Element.fill
            , Element.spacing <| 8
            ]
        , content =
            { divider = { element = [] }
            , title =
                Typography.subtitle2
                    ++ [ withPaletteAttribute
                            (Palette.gray
                                >> MaterialColor.fromColor
                            )
                            Font.color
                       , Element.paddingXY 16 8
                       ]
            }
        }
    }


fullBleedItem : ItemStyle (FullBleedItemStyle context (Theme theme) msg) context (Theme theme) msg
fullBleedItem =
    let
        i =
            insetItem
    in
    { element = i.element
    , content =
        { elementButton = i.content.elementButton
        , ifDisabled = i.content.ifDisabled
        , otherwise = i.content.otherwise
        , content =
            { elementRow = i.content.content.elementRow
            , content =
                { text = i.content.content.content.text
                , icon = i.content.content.content.content
                }
            }
        }
    }


insetItem : ItemStyle (InsetItemStyle context (Theme theme) msg) context (Theme theme) msg
insetItem =
    { element = [ Element.padding 0 ]
    , content =
        { elementButton =
            [ Element.width Element.fill
            , Element.padding 16
            ]
        , ifDisabled =
            [ Element.mouseDown []
            , Element.mouseOver []
            , Element.focused []
            , Element.htmlAttribute <| Attributes.style "cursor" "default"
            ]
        , otherwise =
            [ Element.mouseDown <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.focused <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.mouseOver <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            ]
        , content =
            { elementRow = [ Element.spacing 16, Element.width Element.fill ]
            , content =
                { text = { elementText = [ Element.width Element.fill ] }
                , icon =
                    { element =
                        [ Element.width <| Element.px 40
                        , Element.height <| Element.px 24
                        ]
                    , content =
                        { size = 24
                        , color = getPalette >> Palette.gray
                        }
                    }
                , content =
                    { size = 24
                    , color = getPalette >> Palette.gray
                    }
                }
            }
        }
    }


multiLineItem : ItemStyle (MultiLineItemStyle context (Theme theme) msg) context (Theme theme) msg
multiLineItem =
    { element = [ Element.padding 0 ]
    , content =
        { elementButton =
            [ Element.width Element.fill
            , Element.padding 16
            ]
        , ifDisabled =
            [ Element.mouseDown []
            , Element.mouseOver []
            , Element.focused []
            , Element.htmlAttribute <| Attributes.style "cursor" "default"
            ]
        , otherwise =
            [ Element.mouseDown <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.focused <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.mouseOver <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            ]
        , content =
            { elementRow = [ Element.spacing 16, Element.width Element.fill ]
            , content =
                { description =
                    { elementColumn =
                        [ Element.width Element.fill
                        , Element.spacing 4
                        ]
                    , content =
                        { title = { elementText = Typography.body1 }
                        , text =
                            { elementText =
                                Typography.body2
                                    ++ [ withPaletteAttribute
                                            (Palette.gray
                                                >> MaterialColor.fromColor
                                            )
                                            Font.color
                                       ]
                            }
                        }
                    }
                , icon =
                    { element =
                        [ Element.width <| Element.px 40
                        , Element.height <| Element.px 24
                        ]
                    , content =
                        { size = 24
                        , color = getPalette >> Palette.textGray
                        }
                    }
                , content =
                    { size = 24
                    , color = getPalette >> Palette.textGray
                    }
                }
            }
        }
    }


imageItem : ItemStyle (ImageItemStyle context (Theme theme) msg) context (Theme theme) msg
imageItem =
    { element = [ Element.padding 0 ]
    , content =
        { elementButton =
            [ Element.width Element.fill
            , Element.paddingXY 16 8
            ]
        , ifDisabled =
            [ Element.mouseDown []
            , Element.mouseOver []
            , Element.focused []
            , Element.htmlAttribute <| Attributes.style "cursor" "default"
            ]
        , otherwise =
            [ Element.mouseDown <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.focused <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.mouseOver <|
                [ withPaletteDecoration
                    (Palette.gray
                        >> MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            ]
        , content =
            { elementRow = [ Element.spacing 16, Element.width Element.fill ]
            , content =
                { text =
                    { elementText =
                        [ Element.width Element.fill
                        ]
                    }
                , image =
                    { element =
                        [ Element.width <| Element.px 40
                        , Element.height <| Element.px 40
                        ]
                    }
                , content =
                    { size = 24
                    , color = getPalette >> Palette.gray
                    }
                }
            }
        }
    }


expansionItem : ExpansionItemStyle context (Theme theme) msg
expansionItem =
    { item = insetItem
    , expandIcon = Icon.expand_more
    , collapseIcon = Icon.expand_less
    }


selectItem : ItemStyle (ButtonStyle context (Theme theme) msg) context (Theme theme) msg
selectItem =
    { element = [ Element.paddingXY 8 4 ]
    , content =
        { elementButton =
            [ Font.size 14
            , Font.semiBold
            , Font.letterSpacing 0.25
            , Element.height <| Element.px 36
            , Element.width <| Element.fill
            , Element.paddingXY 8 8
            , Border.rounded <| 4
            , withSurfaceAttribute
                (MaterialColor.accessibleTextColor
                    >> MaterialColor.fromColor
                )
                Font.color
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
            [ withPrimaryAttribute
                (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                    >> MaterialColor.fromColor
                )
                Background.color
            , withPrimaryAttribute
                MaterialColor.fromColor
                Font.color
            ]
        , otherwise =
            []
        , content =
            { elementRow =
                [ Element.spacing <| 8
                , Element.width <| Element.minimum 32 <| Element.shrink
                , Element.centerY
                ]
            , content =
                { text =
                    { contentText = [ Element.centerX ]
                    }
                , icon =
                    { ifActive =
                        { size = 18
                        , color = getSurfaceColor >> MaterialColor.accessibleTextColor
                        }
                    , ifDisabled =
                        { size = 18
                        , color = getPalette >> Palette.gray
                        }
                    , otherwise =
                        { size = 18
                        , color = getSurfaceColor >> MaterialColor.accessibleTextColor
                        }
                    }
                }
            }
        }
    }
