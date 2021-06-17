module Internal.Item exposing
    ( DividerStyle
    , ExpansionItem
    , ExpansionItemStyle
    , FullBleedItemStyle
    , HeaderStyle
    , ImageItem
    , ImageItemStyle
    , InsetItem
    , InsetItemStyle
    , Item
    , ItemStyle
    , MultiLineItemStyle
    , asItem
    , divider
    , expansionItem
    , fullBleedItem
    , headerItem
    , imageItem
    , insetItem
    , multiLineItem
    , selectItem
    , toItem
    )

import Element.WithContext as Element
import Element.WithContext.Input as Input
import Internal.Button exposing (Button, ButtonStyle)
import Internal.Context exposing (Attribute, Element)
import Internal.Select as Select exposing (Select)
import Widget.Icon exposing (Icon, IconStyle)


type alias ItemStyle content context msg =
    { element : List (Attribute context msg)
    , content : content
    }


type alias DividerStyle context msg =
    { element : List (Attribute context msg)
    }


type alias HeaderStyle context msg =
    { elementColumn : List (Attribute context msg)
    , content :
        { divider : DividerStyle context msg
        , title : List (Attribute context msg)
        }
    }


type alias FullBleedItemStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { text : { elementText : List (Attribute context msg) }
            , icon : IconStyle context
            }
        }
    }


type alias InsetItemStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { text : { elementText : List (Attribute context msg) }
            , icon :
                { element : List (Attribute context msg)
                , content : IconStyle context
                }
            , content : IconStyle context
            }
        }
    }


type alias MultiLineItemStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { description :
                { elementColumn : List (Attribute context msg)
                , content :
                    { title : { elementText : List (Attribute context msg) }
                    , text : { elementText : List (Attribute context msg) }
                    }
                }
            , icon :
                { element : List (Attribute context msg)
                , content : IconStyle context
                }
            , content : IconStyle context
            }
        }
    }


type alias ImageItemStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { text : { elementText : List (Attribute context msg) }
            , image : { element : List (Attribute context msg) }
            , content : IconStyle context
            }
        }
    }


type alias ExpansionItemStyle context msg =
    { item : ItemStyle (InsetItemStyle context msg) context msg
    , expandIcon : Icon context msg
    , collapseIcon : Icon context msg
    }


type alias Item context msg =
    List (Attribute context msg) -> Element context msg


type alias InsetItem context msg =
    { text : String
    , onPress : Maybe msg
    , icon : Icon context msg
    , content : Icon context msg
    }


type alias ImageItem context msg =
    { text : String
    , onPress : Maybe msg
    , image : Element context msg
    , content : Icon context msg
    }


type alias ExpansionItem context msg =
    { icon : Icon context msg
    , text : String
    , onToggle : Bool -> msg
    , content : List (Item context msg)
    , isExpanded : Bool
    }


type alias MultiLineItem context msg =
    { title : String
    , text : String
    , onPress : Maybe msg
    , icon : Icon context msg
    , content : Icon context msg
    }


fullBleedItem : ItemStyle (FullBleedItemStyle context msg) context msg -> Button context msg -> Item context msg
fullBleedItem s { onPress, text, icon } =
    toItem s
        (\style ->
            Input.button
                (style.elementButton
                    ++ (if onPress == Nothing then
                            style.ifDisabled

                        else
                            style.otherwise
                       )
                )
                { onPress = onPress
                , label =
                    [ text
                        |> Element.text
                        |> List.singleton
                        |> Element.paragraph []
                        |> Element.el style.content.content.text.elementText
                    , icon style.content.content.icon
                    ]
                        |> Element.row style.content.elementRow
                }
        )


asItem : Element context msg -> Item context msg
asItem element =
    toItem
        { element = []
        , content = ()
        }
        (always element)


divider : ItemStyle (DividerStyle context msg) context msg -> Item context msg
divider style =
    toItem style (\{ element } -> Element.none |> Element.el element)


headerItem : ItemStyle (HeaderStyle context msg) context msg -> String -> Item context msg
headerItem style title =
    toItem style
        (\{ elementColumn, content } ->
            [ Element.none
                |> Element.el content.divider.element
            , title
                |> Element.text
                |> Element.el content.title
            ]
                |> Element.column elementColumn
        )


insetItem : ItemStyle (InsetItemStyle context msg) context msg -> InsetItem context msg -> Item context msg
insetItem s { onPress, text, icon, content } =
    toItem s
        (\style ->
            Input.button
                (style.elementButton
                    ++ (if onPress == Nothing then
                            style.ifDisabled

                        else
                            style.otherwise
                       )
                )
                { onPress = onPress
                , label =
                    [ icon style.content.content.icon.content
                        |> Element.el style.content.content.icon.element
                    , text
                        |> Element.text
                        |> List.singleton
                        |> Element.paragraph []
                        |> Element.el style.content.content.text.elementText
                    , content style.content.content.content
                    ]
                        |> Element.row style.content.elementRow
                }
        )


imageItem : ItemStyle (ImageItemStyle context msg) context msg -> ImageItem context msg -> Item context msg
imageItem s { onPress, text, image, content } =
    toItem s
        (\style ->
            Input.button
                (style.elementButton
                    ++ (if onPress == Nothing then
                            style.ifDisabled

                        else
                            style.otherwise
                       )
                )
                { onPress = onPress
                , label =
                    [ image
                        |> Element.el style.content.content.image.element
                    , text
                        |> Element.text
                        |> List.singleton
                        |> Element.paragraph []
                        |> Element.el style.content.content.text.elementText
                    , content style.content.content.content
                    ]
                        |> Element.row style.content.elementRow
                }
        )


expansionItem : ExpansionItemStyle context msg -> ExpansionItem context msg -> List (Item context msg)
expansionItem s { icon, text, onToggle, content, isExpanded } =
    insetItem s.item
        { text = text
        , onPress = Just <| onToggle <| not isExpanded
        , icon = icon
        , content =
            if isExpanded then
                s.collapseIcon

            else
                s.expandIcon
        }
        :: (if isExpanded then
                content

            else
                []
           )


multiLineItem : ItemStyle (MultiLineItemStyle context msg) context msg -> MultiLineItem context msg -> Item context msg
multiLineItem s { onPress, title, text, icon, content } =
    toItem s
        (\style ->
            Input.button
                (style.elementButton
                    ++ (if onPress == Nothing then
                            style.ifDisabled

                        else
                            style.otherwise
                       )
                )
                { onPress = onPress
                , label =
                    [ icon style.content.content.icon.content
                        |> Element.el style.content.content.icon.element
                    , [ title
                            |> Element.text
                            |> List.singleton
                            |> Element.paragraph style.content.content.description.content.title.elementText
                      , text
                            |> Element.text
                            |> List.singleton
                            |> Element.paragraph style.content.content.description.content.text.elementText
                      ]
                        |> Element.column style.content.content.description.elementColumn
                    , content style.content.content.content
                    ]
                        |> Element.row style.content.elementRow
                }
        )


selectItem : ItemStyle (ButtonStyle context msg) context msg -> Select context msg -> List (Item context msg)
selectItem s select =
    select
        |> Select.select
        |> List.map (\b -> toItem s (\style -> b |> Select.selectButton style))



--------------------------------------------------------------------------------
-- Internal
--------------------------------------------------------------------------------


toItem : ItemStyle style context msg -> (style -> Element context msg) -> Item context msg
toItem style element =
    \attr ->
        element style.content
            |> Element.el
                (attr ++ style.element)
