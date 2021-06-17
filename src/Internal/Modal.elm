module Internal.Modal exposing (Modal, multiModal, singleModal)

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Events as Events
import Internal.Context exposing (Attribute, Element)


type alias Modal context msg =
    { onDismiss : Maybe msg
    , content : Element context msg
    }


background : Maybe msg -> List (Attribute context msg)
background onDismiss =
    [ Element.none
        |> Element.el
            ([ Element.width <| Element.fill
             , Element.height <| Element.fill
             , Background.color <| Element.rgba255 0 0 0 0.5
             ]
                ++ (onDismiss
                        |> Maybe.map (Events.onClick >> List.singleton)
                        |> Maybe.withDefault []
                   )
            )
        |> Element.inFront
    , Element.clip
    ]


singleModal : List (Modal context msg) -> List (Attribute context msg)
singleModal =
    List.head
        >> Maybe.map
            (\{ onDismiss, content } ->
                background onDismiss ++ [ content |> Element.inFront ]
            )
        >> Maybe.withDefault []


multiModal : List (Modal context msg) -> List (Attribute context msg)
multiModal list =
    case list of
        head :: tail ->
            (tail
                |> List.reverse
                |> List.map (\{ content } -> content |> Element.inFront)
            )
                ++ background head.onDismiss
                ++ [ head.content |> Element.inFront ]

        _ ->
            []
