module Internal.PasswordInput exposing
    ( PasswordInput
    , PasswordInputStyle
    , currentPasswordInput
    , newPasswordInput
    )

import Element.WithContext as Element
import Element.WithContext.Input as Input
import Internal.Context exposing (Attribute, Element, Label, Placeholder)


{-| -}
type alias PasswordInputStyle context msg =
    { elementRow : List (Attribute context msg)
    , content :
        { password :
            { elementPasswordInput : List (Attribute context msg)
            }
        }
    }


type alias PasswordInput context msg =
    { text : String
    , placeholder : Maybe (Placeholder context msg)
    , label : String
    , onChange : String -> msg
    , show : Bool
    }


password :
    (List (Attribute context msg)
     ->
        { onChange : String -> msg
        , text : String
        , placeholder : Maybe (Placeholder context msg)
        , label : Label context msg
        , show : Bool
        }
     -> Element context msg
    )
    -> PasswordInputStyle context msg
    -> PasswordInput context msg
    -> Element context msg
password input style { placeholder, label, text, onChange, show } =
    Element.row style.elementRow
        [ input style.content.password.elementPasswordInput
            { onChange = onChange
            , text = text
            , placeholder = placeholder
            , label = Input.labelHidden label
            , show = show
            }
        ]


currentPasswordInput : PasswordInputStyle context msg -> PasswordInput context msg -> Element context msg
currentPasswordInput =
    password Input.currentPassword


newPasswordInput : PasswordInputStyle context msg -> PasswordInput context msg -> Element context msg
newPasswordInput =
    password Input.newPassword
