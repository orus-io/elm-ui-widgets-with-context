module Internal.List exposing (ColumnStyle, RowStyle, buttonColumn, buttonRow, column, itemList, row, toggleRow, wrappedButtonRow)

import Element.WithContext as Element
import Internal.Button exposing (Button, ButtonStyle)
import Internal.Context exposing (Attribute, Context, Element)
import Internal.Item as Item exposing (Item)
import Internal.Select as Select
import Widget.Customize as Customize


{-| -}
type alias RowStyle context msg =
    { elementRow : List (Attribute context msg)
    , content :
        { element : List (Attribute context msg)
        , ifFirst : List (Attribute context msg)
        , ifLast : List (Attribute context msg)
        , ifSingleton : List (Attribute context msg)
        , otherwise : List (Attribute context msg)
        }
    }


{-| -}
type alias ColumnStyle context msg =
    { elementColumn : List (Attribute context msg)
    , content :
        { element : List (Attribute context msg)
        , ifFirst : List (Attribute context msg)
        , ifLast : List (Attribute context msg)
        , ifSingleton : List (Attribute context msg)
        , otherwise : List (Attribute context msg)
        }
    }


internal :
    { element : List (Attribute context msg)
    , ifFirst : List (Attribute context msg)
    , ifLast : List (Attribute context msg)
    , ifSingleton : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    }
    -> List (Item context msg)
    -> List (Element context msg)
internal style list =
    list
        |> List.indexedMap
            (\i fun ->
                fun
                    (style.element
                        ++ (if List.length list == 1 then
                                style.ifSingleton

                            else if i == 0 then
                                style.ifFirst

                            else if i == (List.length list - 1) then
                                style.ifLast

                            else
                                style.otherwise
                           )
                    )
            )


row : RowStyle context msg -> List (Element context msg) -> Element context msg
row style =
    List.map
        (\a ->
            Item.toItem
                { element = style.content.element
                , content = ()
                }
                (always a)
        )
        >> internal style.content
        >> Element.row style.elementRow


column : ColumnStyle context msg -> List (Element context msg) -> Element context msg
column style =
    List.map
        (\a ->
            Item.toItem
                { element = style.content.element
                , content = ()
                }
                (always a)
        )
        >> itemList style


itemList : ColumnStyle context msg -> List (Item context msg) -> Element context msg
itemList style =
    internal
        style.content
        >> Element.column
            style.elementColumn


internalButton :
    { element : List (Attribute context msg)
    , ifSingleton : List (Attribute context msg)
    , ifFirst : List (Attribute context msg)
    , ifLast : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> List (Element context msg)
internalButton style list =
    list
        |> List.indexedMap
            (\i ->
                Select.selectButton
                    (style.content
                        |> Customize.elementButton
                            (style.element
                                ++ (if List.length list == 1 then
                                        style.ifSingleton

                                    else if i == 0 then
                                        style.ifFirst

                                    else if i == (List.length list - 1) then
                                        style.ifLast

                                    else
                                        style.otherwise
                                   )
                            )
                    )
            )


toggleRow :
    { elementRow : RowStyle context msg
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> Element context msg
toggleRow style list =
    (list
        |> List.indexedMap
            (\i ->
                Select.toggleButton
                    (style.content
                        |> Customize.elementButton
                            (style.elementRow.content.element
                                ++ (if List.length list == 1 then
                                        style.elementRow.content.ifSingleton

                                    else if i == 0 then
                                        style.elementRow.content.ifFirst

                                    else if i == (List.length list - 1) then
                                        style.elementRow.content.ifLast

                                    else
                                        style.elementRow.content.otherwise
                                   )
                            )
                    )
            )
    )
        |> Element.row style.elementRow.elementRow


buttonRow :
    { elementRow : RowStyle context msg
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> Element context msg
buttonRow style =
    internalButton
        { element =
            style.elementRow.content.element
        , ifSingleton =
            style.elementRow.content.ifSingleton
        , ifFirst =
            style.elementRow.content.ifFirst
        , ifLast =
            style.elementRow.content.ifLast
        , otherwise =
            style.elementRow.content.otherwise
        , content = style.content
        }
        >> Element.row style.elementRow.elementRow


wrappedButtonRow :
    { elementRow : RowStyle context msg
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> Element context msg
wrappedButtonRow style =
    internalButton
        { element =
            style.elementRow.content.element
        , ifSingleton =
            style.elementRow.content.ifSingleton
        , ifFirst =
            style.elementRow.content.ifFirst
        , ifLast =
            style.elementRow.content.ifLast
        , otherwise =
            style.elementRow.content.otherwise
        , content = style.content
        }
        >> Element.wrappedRow style.elementRow.elementRow


buttonColumn :
    { elementColumn : ColumnStyle context msg
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> Element context msg
buttonColumn style =
    internalButton
        { element =
            style.elementColumn.content.element
        , ifSingleton =
            style.elementColumn.content.ifSingleton
        , ifFirst =
            style.elementColumn.content.ifFirst
        , ifLast =
            style.elementColumn.content.ifLast
        , otherwise =
            style.elementColumn.content.otherwise
        , content = style.content
        }
        >> Element.column style.elementColumn.elementColumn
