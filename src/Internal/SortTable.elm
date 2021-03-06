module Internal.SortTable exposing
    ( Column
    , ColumnType
    , SortTable
    , SortTableStyle
    , floatColumn
    , intColumn
    , sortTable
    , stringColumn
    , unsortableColumn
    )

import Element.WithContext as Element exposing (Length)
import Internal.Button as Button exposing (ButtonStyle)
import Internal.Context exposing (Attribute, Element)
import Widget.Icon exposing (Icon)


{-| Technical Remark:

  - If icons are defined in Svg, they might not display correctly.
    To avoid that, make sure to wrap them in `Element.html >> Element.el []`

-}
type alias SortTableStyle context msg =
    { elementTable : List (Attribute context msg)
    , content :
        { header : ButtonStyle context msg
        , ascIcon : Icon context msg
        , descIcon : Icon context msg
        , defaultIcon : Icon context msg
        }
    }


{-| A Sortable list allows you to sort coulmn.
-}
type ColumnType a
    = StringColumn { value : a -> String, toString : String -> String }
    | IntColumn { value : a -> Int, toString : Int -> String }
    | FloatColumn { value : a -> Float, toString : Float -> String }
    | UnsortableColumn (a -> String)


{-| The Model contains the sorting column name and if ascending or descending.
-}
type alias SortTable a msg =
    { content : List a
    , columns : List (Column a)
    , sortBy : String
    , asc : Bool
    , onChange : String -> msg
    }


type Column a
    = Column
        { title : String
        , content : ColumnType a
        , width : Length
        }


unsortableColumn : { title : String, toString : a -> String, width : Length } -> Column a
unsortableColumn { title, toString, width } =
    Column
        { title = title
        , content = UnsortableColumn toString
        , width = width
        }


{-| A Column containing a Int
-}
intColumn : { title : String, value : a -> Int, toString : Int -> String, width : Length } -> Column a
intColumn { title, value, toString, width } =
    Column
        { title = title
        , content = IntColumn { value = value, toString = toString }
        , width = width
        }


{-| A Column containing a Float
-}
floatColumn : { title : String, value : a -> Float, toString : Float -> String, width : Length } -> Column a
floatColumn { title, value, toString, width } =
    Column
        { title = title
        , content = FloatColumn { value = value, toString = toString }
        , width = width
        }


{-| A Column containing a String
-}
stringColumn : { title : String, value : a -> String, toString : String -> String, width : Length } -> Column a
stringColumn { title, value, toString, width } =
    Column
        { title = title
        , content = StringColumn { value = value, toString = toString }
        , width = width
        }


{-| The View
-}
sortTable :
    SortTableStyle context msg
    -> SortTable a msg
    -> Element context msg
sortTable style model =
    let
        findTitle : List (Column a) -> Maybe (ColumnType a)
        findTitle list =
            case list of
                [] ->
                    Nothing

                (Column head) :: tail ->
                    if head.title == model.sortBy then
                        Just head.content

                    else
                        findTitle tail
    in
    Element.table style.elementTable
        { data =
            model.content
                |> (model.columns
                        |> findTitle
                        |> Maybe.andThen
                            (\c ->
                                case c of
                                    StringColumn { value } ->
                                        Just <| List.sortBy value

                                    IntColumn { value } ->
                                        Just <| List.sortBy value

                                    FloatColumn { value } ->
                                        Just <| List.sortBy value

                                    UnsortableColumn _ ->
                                        Nothing
                            )
                        |> Maybe.withDefault identity
                   )
                |> (if model.asc then
                        identity

                    else
                        List.reverse
                   )
        , columns =
            model.columns
                |> List.map
                    (\(Column column) ->
                        { header =
                            Button.button style.content.header
                                { text = column.title
                                , icon =
                                    if column.title == model.sortBy then
                                        if model.asc then
                                            style.content.ascIcon

                                        else
                                            style.content.descIcon

                                    else
                                        style.content.defaultIcon
                                , onPress =
                                    case column.content of
                                        UnsortableColumn _ ->
                                            Nothing

                                        _ ->
                                            Just <| model.onChange <| column.title
                                }
                        , width = column.width
                        , view =
                            (case column.content of
                                IntColumn { value, toString } ->
                                    value >> toString

                                FloatColumn { value, toString } ->
                                    value >> toString

                                StringColumn { value, toString } ->
                                    value >> toString

                                UnsortableColumn toString ->
                                    toString
                            )
                                >> Element.text
                                >> List.singleton
                                >> Element.paragraph []
                        }
                    )
        }
