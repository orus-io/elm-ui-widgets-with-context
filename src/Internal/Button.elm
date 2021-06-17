module Internal.Button exposing (Button, ButtonStyle, TextButton, button, iconButton, textButton)

import Element.WithContext as Element exposing (Attribute, Element)
import Element.WithContext.Input as Input
import Element.WithContext.Region as Region
import Internal.Context exposing (Attribute, Context, Element)
import Widget.Icon exposing (Icon, IconStyle)


type alias ButtonStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , ifActive : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { text : { contentText : List (Attribute context msg) }
            , icon :
                { ifDisabled : IconStyle context
                , ifActive : IconStyle context
                , otherwise : IconStyle context
                }
            }
        }
    }


type alias Button context msg =
    { text : String
    , onPress : Maybe msg
    , icon : Icon context msg
    }


type alias TextButton msg =
    { text : String
    , onPress : Maybe msg
    }


iconButton : ButtonStyle context msg -> Button context msg -> Element context msg
iconButton style { onPress, text, icon } =
    Input.button
        (style.elementButton
            ++ (if onPress == Nothing then
                    style.ifDisabled

                else
                    style.otherwise
               )
            ++ [ Region.description text ]
        )
        { onPress = onPress
        , label =
            icon
                (if onPress == Nothing then
                    style.content.content.icon.ifDisabled

                 else
                    style.content.content.icon.otherwise
                )
                |> Element.el style.content.elementRow
        }


textButton : ButtonStyle context msg -> TextButton msg -> Element context msg
textButton style { onPress, text } =
    button style
        { onPress = onPress
        , text = text
        , icon = always Element.none
        }


button :
    ButtonStyle context msg
    -> Button context msg
    -> Element context msg
button style { onPress, text, icon } =
    Input.button
        (style.elementButton
            ++ (if onPress == Nothing then
                    style.ifDisabled

                else
                    style.otherwise
               )
            ++ [ Region.description text ]
        )
        { onPress = onPress
        , label =
            Element.row style.content.elementRow
                [ icon
                    (if onPress == Nothing then
                        style.content.content.icon.ifDisabled

                     else
                        style.content.content.icon.otherwise
                    )
                , Element.text text
                    |> Element.el style.content.content.text.contentText
                ]
        }
