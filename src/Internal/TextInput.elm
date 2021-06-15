module Internal.TextInput exposing (TextInput, TextInputStyle, textInput)

import Element.WithContext as Element
import Element.WithContext.Input as Input
import Internal.Button as Button exposing (Button, ButtonStyle)
import Internal.Context exposing (Attribute, Element, Placeholder)


{-| -}
type alias TextInputStyle context theme msg =
    { elementRow : List (Attribute context theme msg)
    , content :
        { chips :
            { elementRow : List (Attribute context theme msg)
            , content : ButtonStyle context theme msg
            }
        , text :
            { elementTextInput : List (Attribute context theme msg)
            }
        }
    }


type alias TextInput context theme msg =
    { chips : List (Button context theme msg)
    , text : String
    , placeholder : Maybe (Placeholder context theme msg)
    , label : String
    , onChange : String -> msg
    }


textInput : TextInputStyle context theme msg -> TextInput context theme msg -> Element context theme msg
textInput style { chips, placeholder, label, text, onChange } =
    Element.row style.elementRow
        [ if chips |> List.isEmpty then
            Element.none

          else
            chips
                |> List.map
                    (Button.button style.content.chips.content)
                |> Element.row style.content.chips.elementRow
        , Input.text style.content.text.elementTextInput
            { onChange = onChange
            , text = text
            , placeholder = placeholder
            , label = Input.labelHidden label
            }
        ]
