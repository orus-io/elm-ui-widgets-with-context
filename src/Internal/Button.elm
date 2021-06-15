module Internal.Button exposing (Button, ButtonStyle, TextButton, button, iconButton, textButton)

import Element.WithContext as Element exposing (Attribute, Element)
import Element.WithContext.Input as Input
import Element.WithContext.Region as Region
import Internal.Context exposing (Attribute, Context, Element)
import Widget.Icon exposing (Icon, IconStyle)


type alias ButtonStyle context theme msg =
    { elementButton : List (Attribute context theme msg)
    , ifDisabled : List (Attribute context theme msg)
    , ifActive : List (Attribute context theme msg)
    , otherwise : List (Attribute context theme msg)
    , content :
        { elementRow : List (Attribute context theme msg)
        , content :
            { text : { contentText : List (Attribute context theme msg) }
            , icon :
                { ifDisabled : IconStyle theme
                , ifActive : IconStyle theme
                , otherwise : IconStyle theme
                }
            }
        }
    }


type alias Button context theme msg =
    { text : String
    , onPress : Maybe msg
    , icon : Icon context theme msg
    }


type alias TextButton msg =
    { text : String
    , onPress : Maybe msg
    }


iconButton : ButtonStyle context theme msg -> Button context theme msg -> Element context theme msg
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


textButton : ButtonStyle context theme msg -> TextButton msg -> Element context theme msg
textButton style { onPress, text } =
    button style
        { onPress = onPress
        , text = text
        , icon = always Element.none
        }


button :
    ButtonStyle context theme msg
    -> Button context theme msg
    -> Element context theme msg
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
