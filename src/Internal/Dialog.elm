module Internal.Dialog exposing (Dialog, DialogStyle, dialog)

import Element.WithContext as Element
import Internal.Button as Button exposing (ButtonStyle, TextButton)
import Internal.Context exposing (Attribute, Context)
import Internal.Modal exposing (Modal)


{-| -}
type alias DialogStyle context msg =
    { elementColumn : List (Attribute context msg)
    , content :
        { title :
            { contentText : List (Attribute context msg)
            }
        , text :
            { contentText : List (Attribute context msg)
            }
        , buttons :
            { elementRow : List (Attribute context msg)
            , content :
                { accept : ButtonStyle context msg
                , dismiss : ButtonStyle context msg
                }
            }
        }
    }


type alias Dialog msg =
    { title : Maybe String
    , text : String
    , accept : Maybe (TextButton msg)
    , dismiss : Maybe (TextButton msg)
    }


dialog :
    DialogStyle context msg
    -> Dialog msg
    -> Modal context msg
dialog style { title, text, accept, dismiss } =
    { onDismiss =
        case ( accept, dismiss ) of
            ( Nothing, Nothing ) ->
                Nothing

            ( Nothing, Just { onPress } ) ->
                onPress

            ( Just _, _ ) ->
                Nothing
    , content =
        Element.column
            ([ Element.centerX
             , Element.centerY
             ]
                ++ style.elementColumn
            )
            [ title
                |> Maybe.map
                    (Element.text
                        >> Element.el style.content.title.contentText
                    )
                |> Maybe.withDefault Element.none
            , text
                |> Element.text
                |> List.singleton
                |> Element.paragraph style.content.text.contentText
            , Element.row
                ([ Element.alignRight
                 , Element.width <| Element.shrink
                 ]
                    ++ style.content.buttons.elementRow
                )
                (case ( accept, dismiss ) of
                    ( Just acceptButton, Nothing ) ->
                        acceptButton
                            |> Button.textButton style.content.buttons.content.accept
                            |> List.singleton

                    ( Just acceptButton, Just dismissButton ) ->
                        [ dismissButton
                            |> Button.textButton style.content.buttons.content.dismiss
                        , acceptButton
                            |> Button.textButton style.content.buttons.content.accept
                        ]

                    _ ->
                        []
                )
            ]
    }
