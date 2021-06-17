module Internal.TextInput exposing (TextInput, TextInputStyle, textInput)

import Element.WithContext as Element
import Element.WithContext.Input as Input
import Internal.Button as Button exposing (Button, ButtonStyle)
import Internal.Context exposing (Attribute, Element, Placeholder)


{-| -}
type alias TextInputStyle context msg =
    { elementRow : List (Attribute context msg)
    , content :
        { chips :
            { elementRow : List (Attribute context msg)
            , content : ButtonStyle context msg
            }
        , text :
            { elementTextInput : List (Attribute context msg)
            }
        }
    }


type alias TextInput context msg =
    { chips : List (Button context msg)
    , text : String
    , placeholder : Maybe (Placeholder context msg)
    , label : String
    , onChange : String -> msg
    }


textInput : TextInputStyle context msg -> TextInput context msg -> Element context msg
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
