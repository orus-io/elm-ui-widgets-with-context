module Internal.Select exposing (MultiSelect, Select, multiSelect, select, selectButton, toggleButton)

import Element.WithContext as Element
import Element.WithContext.Input as Input
import Element.WithContext.Region as Region
import Internal.Button exposing (Button, ButtonStyle)
import Internal.Context exposing (Element)
import Set exposing (Set)
import Widget.Icon exposing (Icon)


type alias Select context msg =
    { selected : Maybe Int
    , options :
        List
            { text : String
            , icon : Icon context msg
            }
    , onSelect : Int -> Maybe msg
    }


type alias MultiSelect context msg =
    { selected : Set Int
    , options :
        List
            { text : String
            , icon : Icon context msg
            }
    , onSelect : Int -> Maybe msg
    }


selectButton :
    ButtonStyle context msg
    -> ( Bool, Button context msg )
    -> Element context msg
selectButton style ( selected, b ) =
    Input.button
        (style.elementButton
            ++ (if b.onPress == Nothing then
                    style.ifDisabled

                else if selected then
                    style.ifActive

                else
                    style.otherwise
               )
            ++ [ Region.description b.text ]
        )
        { onPress = b.onPress
        , label =
            Element.row style.content.elementRow
                [ b.icon
                    (if b.onPress == Nothing then
                        style.content.content.icon.ifDisabled

                     else if selected then
                        style.content.content.icon.ifActive

                     else
                        style.content.content.icon.otherwise
                    )
                , Element.text b.text |> Element.el style.content.content.text.contentText
                ]
        }


toggleButton :
    ButtonStyle context msg
    -> ( Bool, Button context msg )
    -> Element context msg
toggleButton style ( selected, b ) =
    Input.button
        (style.elementButton
            ++ (if b.onPress == Nothing then
                    style.ifDisabled

                else if selected then
                    style.ifActive

                else
                    style.otherwise
               )
            ++ [ Region.description b.text ]
        )
        { onPress = b.onPress
        , label =
            b.icon
                (if b.onPress == Nothing then
                    style.content.content.icon.ifDisabled

                 else if selected then
                    style.content.content.icon.ifActive

                 else
                    style.content.content.icon.otherwise
                )
                |> Element.el style.content.elementRow
        }


select :
    Select context msg
    -> List ( Bool, Button context msg )
select { selected, options, onSelect } =
    options
        |> List.indexedMap
            (\i a ->
                ( selected == Just i
                , { onPress = i |> onSelect
                  , text = a.text
                  , icon = a.icon
                  }
                )
            )


multiSelect :
    MultiSelect context msg
    -> List ( Bool, Button context msg )
multiSelect { selected, options, onSelect } =
    options
        |> List.indexedMap
            (\i a ->
                ( selected |> Set.member i
                , { onPress = i |> onSelect
                  , text = a.text
                  , icon = a.icon
                  }
                )
            )
