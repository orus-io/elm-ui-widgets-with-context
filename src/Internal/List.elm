module Internal.List exposing (ColumnStyle, RowStyle, buttonColumn, buttonRow, column, itemList, row, toggleRow, wrappedButtonRow)

import Element.WithContext as Element
import Internal.Button exposing (Button, ButtonStyle)
import Internal.Context exposing (Attribute, Context, Element)
import Internal.Item as Item exposing (Item)
import Internal.Select as Select
import Widget.Customize as Customize


{-| -}
type alias RowStyle context theme msg =
    { elementRow : List (Attribute context theme msg)
    , content :
        { element : List (Attribute context theme msg)
        , ifFirst : List (Attribute context theme msg)
        , ifLast : List (Attribute context theme msg)
        , ifSingleton : List (Attribute context theme msg)
        , otherwise : List (Attribute context theme msg)
        }
    }


{-| -}
type alias ColumnStyle context theme msg =
    { elementColumn : List (Attribute context theme msg)
    , content :
        { element : List (Attribute context theme msg)
        , ifFirst : List (Attribute context theme msg)
        , ifLast : List (Attribute context theme msg)
        , ifSingleton : List (Attribute context theme msg)
        , otherwise : List (Attribute context theme msg)
        }
    }


internal :
    { element : List (Attribute context theme msg)
    , ifFirst : List (Attribute context theme msg)
    , ifLast : List (Attribute context theme msg)
    , ifSingleton : List (Attribute context theme msg)
    , otherwise : List (Attribute context theme msg)
    }
    -> List (Item context theme msg)
    -> List (Element context theme msg)
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


row : RowStyle context theme msg -> List (Element context theme msg) -> Element context theme msg
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


column : ColumnStyle context theme msg -> List (Element context theme msg) -> Element context theme msg
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


itemList : ColumnStyle context theme msg -> List (Item context theme msg) -> Element context theme msg
itemList style =
    internal
        style.content
        >> Element.column
            style.elementColumn


internalButton :
    { element : List (Attribute context theme msg)
    , ifSingleton : List (Attribute context theme msg)
    , ifFirst : List (Attribute context theme msg)
    , ifLast : List (Attribute context theme msg)
    , otherwise : List (Attribute context theme msg)
    , content : ButtonStyle context theme msg
    }
    -> List ( Bool, Button context theme msg )
    -> List (Element context theme msg)
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
    { elementRow : RowStyle context theme msg
    , content : ButtonStyle context theme msg
    }
    -> List ( Bool, Button context theme msg )
    -> Element context theme msg
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
    { elementRow : RowStyle context theme msg
    , content : ButtonStyle context theme msg
    }
    -> List ( Bool, Button context theme msg )
    -> Element context theme msg
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
    { elementRow : RowStyle context theme msg
    , content : ButtonStyle context theme msg
    }
    -> List ( Bool, Button context theme msg )
    -> Element context theme msg
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
    { elementColumn : ColumnStyle context theme msg
    , content : ButtonStyle context theme msg
    }
    -> List ( Bool, Button context theme msg )
    -> Element context theme msg
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
