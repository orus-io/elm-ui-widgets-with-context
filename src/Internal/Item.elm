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


type alias ItemStyle content context theme msg =
    { element : List (Attribute context theme msg)
    , content : content
    }


type alias DividerStyle context theme msg =
    { element : List (Attribute context theme msg)
    }


type alias HeaderStyle context theme msg =
    { elementColumn : List (Attribute context theme msg)
    , content :
        { divider : DividerStyle context theme msg
        , title : List (Attribute context theme msg)
        }
    }


type alias FullBleedItemStyle context theme msg =
    { elementButton : List (Attribute context theme msg)
    , ifDisabled : List (Attribute context theme msg)
    , otherwise : List (Attribute context theme msg)
    , content :
        { elementRow : List (Attribute context theme msg)
        , content :
            { text : { elementText : List (Attribute context theme msg) }
            , icon : IconStyle theme
            }
        }
    }


type alias InsetItemStyle context theme msg =
    { elementButton : List (Attribute context theme msg)
    , ifDisabled : List (Attribute context theme msg)
    , otherwise : List (Attribute context theme msg)
    , content :
        { elementRow : List (Attribute context theme msg)
        , content :
            { text : { elementText : List (Attribute context theme msg) }
            , icon :
                { element : List (Attribute context theme msg)
                , content : IconStyle theme
                }
            , content : IconStyle theme
            }
        }
    }


type alias MultiLineItemStyle context theme msg =
    { elementButton : List (Attribute context theme msg)
    , ifDisabled : List (Attribute context theme msg)
    , otherwise : List (Attribute context theme msg)
    , content :
        { elementRow : List (Attribute context theme msg)
        , content :
            { description :
                { elementColumn : List (Attribute context theme msg)
                , content :
                    { title : { elementText : List (Attribute context theme msg) }
                    , text : { elementText : List (Attribute context theme msg) }
                    }
                }
            , icon :
                { element : List (Attribute context theme msg)
                , content : IconStyle theme
                }
            , content : IconStyle theme
            }
        }
    }


type alias ImageItemStyle context theme msg =
    { elementButton : List (Attribute context theme msg)
    , ifDisabled : List (Attribute context theme msg)
    , otherwise : List (Attribute context theme msg)
    , content :
        { elementRow : List (Attribute context theme msg)
        , content :
            { text : { elementText : List (Attribute context theme msg) }
            , image : { element : List (Attribute context theme msg) }
            , content : IconStyle theme
            }
        }
    }


type alias ExpansionItemStyle context theme msg =
    { item : ItemStyle (InsetItemStyle context theme msg) context theme msg
    , expandIcon : Icon context theme msg
    , collapseIcon : Icon context theme msg
    }


type alias Item context theme msg =
    List (Attribute context theme msg) -> Element context theme msg


type alias InsetItem context theme msg =
    { text : String
    , onPress : Maybe msg
    , icon : Icon context theme msg
    , content : Icon context theme msg
    }


type alias ImageItem context theme msg =
    { text : String
    , onPress : Maybe msg
    , image : Element context theme msg
    , content : Icon context theme msg
    }


type alias ExpansionItem context theme msg =
    { icon : Icon context theme msg
    , text : String
    , onToggle : Bool -> msg
    , content : List (Item context theme msg)
    , isExpanded : Bool
    }


type alias MultiLineItem context theme msg =
    { title : String
    , text : String
    , onPress : Maybe msg
    , icon : Icon context theme msg
    , content : Icon context theme msg
    }


fullBleedItem : ItemStyle (FullBleedItemStyle context theme msg) context theme msg -> Button context theme msg -> Item context theme msg
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


asItem : Element context theme msg -> Item context theme msg
asItem element =
    toItem
        { element = []
        , content = ()
        }
        (always element)


divider : ItemStyle (DividerStyle context theme msg) context theme msg -> Item context theme msg
divider style =
    toItem style (\{ element } -> Element.none |> Element.el element)


headerItem : ItemStyle (HeaderStyle context theme msg) context theme msg -> String -> Item context theme msg
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


insetItem : ItemStyle (InsetItemStyle context theme msg) context theme msg -> InsetItem context theme msg -> Item context theme msg
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


imageItem : ItemStyle (ImageItemStyle context theme msg) context theme msg -> ImageItem context theme msg -> Item context theme msg
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


expansionItem : ExpansionItemStyle context theme msg -> ExpansionItem context theme msg -> List (Item context theme msg)
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


multiLineItem : ItemStyle (MultiLineItemStyle context theme msg) context theme msg -> MultiLineItem context theme msg -> Item context theme msg
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


selectItem : ItemStyle (ButtonStyle context theme msg) context theme msg -> Select context theme msg -> List (Item context theme msg)
selectItem s select =
    select
        |> Select.select
        |> List.map (\b -> toItem s (\style -> b |> Select.selectButton style))



--------------------------------------------------------------------------------
-- Internal
--------------------------------------------------------------------------------


toItem : ItemStyle style context theme msg -> (style -> Element context theme msg) -> Item context theme msg
toItem style element =
    \attr ->
        element style.content
            |> Element.el
                (attr ++ style.element)
