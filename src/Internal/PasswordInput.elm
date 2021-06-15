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
type alias PasswordInputStyle context theme msg =
    { elementRow : List (Attribute context theme msg)
    , content :
        { password :
            { elementPasswordInput : List (Attribute context theme msg)
            }
        }
    }


type alias PasswordInput context theme msg =
    { text : String
    , placeholder : Maybe (Placeholder context theme msg)
    , label : String
    , onChange : String -> msg
    , show : Bool
    }


password :
    (List (Attribute context theme msg)
     ->
        { onChange : String -> msg
        , text : String
        , placeholder : Maybe (Placeholder context theme msg)
        , label : Label context theme msg
        , show : Bool
        }
     -> Element context theme msg
    )
    -> PasswordInputStyle context theme msg
    -> PasswordInput context theme msg
    -> Element context theme msg
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


currentPasswordInput : PasswordInputStyle context theme msg -> PasswordInput context theme msg -> Element context theme msg
currentPasswordInput =
    password Input.currentPassword


newPasswordInput : PasswordInputStyle context theme msg -> PasswordInput context theme msg -> Element context theme msg
newPasswordInput =
    password Input.newPassword
