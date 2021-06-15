module Internal.Switch exposing (Switch, SwitchStyle, switch)

import Element.WithContext as Element
import Element.WithContext.Input as Input
import Element.WithContext.Region as Region
import Internal.Context exposing (Attribute, Element)


{-| -}
type alias SwitchStyle context theme msg =
    { elementButton : List (Attribute context theme msg)
    , content :
        { element : List (Attribute context theme msg)
        , ifDisabled : List (Attribute context theme msg)
        , ifActive : List (Attribute context theme msg)
        , otherwise : List (Attribute context theme msg)
        }
    , contentInFront :
        { element : List (Attribute context theme msg)
        , ifDisabled : List (Attribute context theme msg)
        , ifActive : List (Attribute context theme msg)
        , otherwise : List (Attribute context theme msg)
        , content :
            { element : List (Attribute context theme msg)
            , ifDisabled : List (Attribute context theme msg)
            , ifActive : List (Attribute context theme msg)
            , otherwise : List (Attribute context theme msg)
            }
        }
    }


type alias Switch msg =
    { description : String
    , onPress : Maybe msg
    , active : Bool
    }


switch : SwitchStyle context theme msg -> Switch msg -> Element context theme msg
switch style { onPress, description, active } =
    Input.button
        (style.elementButton
            ++ [ Region.description description
               , Element.none
                    |> Element.el
                        (style.contentInFront.content.element
                            ++ (if active then
                                    style.contentInFront.content.ifActive

                                else if onPress == Nothing then
                                    style.contentInFront.content.ifDisabled

                                else
                                    style.contentInFront.content.otherwise
                               )
                        )
                    |> Element.el
                        (style.contentInFront.element
                            ++ (if active then
                                    style.contentInFront.ifActive

                                else if onPress == Nothing then
                                    style.contentInFront.ifDisabled

                                else
                                    style.contentInFront.otherwise
                               )
                        )
                    |> Element.inFront
               ]
        )
        { onPress = onPress
        , label =
            Element.none
                |> Element.el
                    (style.content.element
                        ++ (if active then
                                style.content.ifActive

                            else if onPress == Nothing then
                                style.content.ifDisabled

                            else
                                style.content.otherwise
                           )
                    )
        }
