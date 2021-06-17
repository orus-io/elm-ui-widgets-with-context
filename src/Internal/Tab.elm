module Internal.Tab exposing (Tab, TabStyle, tab)

import Element.WithContext as Element
import Internal.Button exposing (ButtonStyle)
import Internal.Context exposing (Attribute, Element)
import Internal.Select as Select exposing (Select)


{-| -}
type alias TabStyle context msg =
    { elementColumn : List (Attribute context msg)
    , content :
        { tabs :
            { elementRow : List (Attribute context msg)
            , content : ButtonStyle context msg
            }
        , content : List (Attribute context msg)
        }
    }


type alias Tab context msg =
    { tabs : Select context msg
    , content : Maybe Int -> Element context msg
    }


tab : TabStyle context msg -> Tab context msg -> Element context msg
tab style { tabs, content } =
    [ tabs
        |> Select.select
        |> List.map (Select.selectButton style.content.tabs.content)
        |> Element.row style.content.tabs.elementRow
    , tabs.selected
        |> content
        |> Element.el style.content.content
    ]
        |> Element.column style.elementColumn
