module Internal.Tab exposing (Tab, TabStyle, tab)

import Element.WithContext as Element
import Internal.Button exposing (ButtonStyle)
import Internal.Context exposing (Attribute, Element)
import Internal.Select as Select exposing (Select)


{-| -}
type alias TabStyle context theme msg =
    { elementColumn : List (Attribute context theme msg)
    , content :
        { tabs :
            { elementRow : List (Attribute context theme msg)
            , content : ButtonStyle context theme msg
            }
        , content : List (Attribute context theme msg)
        }
    }


type alias Tab context theme msg =
    { tabs : Select context theme msg
    , content : Maybe Int -> Element context theme msg
    }


tab : TabStyle context theme msg -> Tab context theme msg -> Element context theme msg
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
