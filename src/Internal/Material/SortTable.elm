module Internal.Material.SortTable exposing (sortTable)

import Element.WithContext as Element
import Internal.Context exposing (Context)
import Internal.Material.Button as Button
import Internal.Material.Icon as Icon
import Internal.Material.Palette exposing (Palette)
import Internal.SortTable exposing (SortTableStyle)
import Widget.Material.Context exposing (Context)


sortTable : SortTableStyle (Context context) msg
sortTable =
    { elementTable = []
    , content =
        { header = Button.textButton
        , ascIcon = Icon.expand_less
        , descIcon = Icon.expand_more
        , defaultIcon = always Element.none
        }
    }
