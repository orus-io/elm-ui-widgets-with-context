module Widget.Layout exposing
    ( leftSheet, rightSheet, searchSheet
    , getDeviceClass, partitionActions, orderModals
    )

{-| Combines multiple concepts from the [Material Design specification](https://material.io/components/), namely:

  - Top App Bar
  - Navigation Draw
  - Side Panel
  - Dialog
  - Snackbar

It is responsive and changes view to apply to the [Material Design guidelines](https://material.io/components/app-bars-top).

![Layout](https://orasund.github.io/elm-ui-widgets/assets/layout.png)


# Sheets

![Sheet](https://orasund.github.io/elm-ui-widgets/assets/sheet.png)

@docs leftSheet, rightSheet, searchSheet


# Utility Functions

@docs getDeviceClass, partitionActions, orderModals

-}

import Element.WithContext as Element exposing (DeviceClass(..))
import Internal.Button exposing (Button, ButtonStyle)
import Internal.Context exposing (Element)
import Internal.Item as Item exposing (InsetItemStyle, ItemStyle)
import Internal.List as List exposing (ColumnStyle)
import Internal.Modal exposing (Modal)
import Internal.Select exposing (Select)
import Internal.TextInput as TextInput exposing (TextInput, TextInputStyle)
import Widget.Customize as Customize


{-| Obtain the device class from a given window.

Checkout [Element.classifyDevice](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/Element#classifyDevice) for more information.

-}
getDeviceClass : { height : Int, width : Int } -> DeviceClass
getDeviceClass window =
    window
        |> Element.classifyDevice
        |> .class


{-| Partitions actions into primary and additional actions.

It is intended to hide the additional actions in a side menu.

-}
partitionActions : List (Button context theme msg) -> { primaryActions : List (Button context theme msg), moreActions : List (Button context theme msg) }
partitionActions actions =
    { primaryActions =
        if (actions |> List.length) > 4 then
            actions |> List.take 2

        else if (actions |> List.length) == 4 then
            actions |> List.take 1

        else if (actions |> List.length) == 3 then
            []

        else
            actions |> List.take 2
    , moreActions =
        if (actions |> List.length) > 4 then
            actions |> List.drop 2

        else if (actions |> List.length) == 4 then
            actions |> List.drop 1

        else if (actions |> List.length) == 3 then
            actions

        else
            actions |> List.drop 2
    }


{-| Left sheet containing a title and a menu.
-}
leftSheet :
    { button : ItemStyle (ButtonStyle context theme msg) context theme msg
    , sheet : ColumnStyle context theme msg
    }
    ->
        { title : Element context theme msg
        , menu : Select context theme msg
        , onDismiss : msg
        }
    -> Modal context theme msg
leftSheet style { title, onDismiss, menu } =
    { onDismiss = Just onDismiss
    , content =
        (title |> Item.asItem)
            :: (menu
                    |> Item.selectItem style.button
               )
            |> List.itemList
                (style.sheet
                    |> Customize.elementColumn [ Element.alignLeft ]
                )
    }


{-| Right sheet containg a simple list of buttons
-}
rightSheet :
    { sheet : ColumnStyle context theme msg
    , insetItem : ItemStyle (InsetItemStyle context theme msg) context theme msg
    }
    ->
        { onDismiss : msg
        , moreActions : List (Button context theme msg)
        }
    -> Modal context theme msg
rightSheet style { onDismiss, moreActions } =
    { onDismiss = Just onDismiss
    , content =
        moreActions
            |> List.map
                (\{ onPress, text, icon } ->
                    Item.insetItem
                        style.insetItem
                        { text = text
                        , onPress = onPress
                        , icon = icon
                        , content = always Element.none
                        }
                )
            |> List.itemList
                (style.sheet
                    |> Customize.elementColumn [ Element.alignRight ]
                )
    }


{-| Top sheet containg a searchbar spaning the full witdh
-}
searchSheet :
    TextInputStyle context theme msg
    ->
        { onDismiss : msg
        , search : TextInput context theme msg
        }
    -> Modal context theme msg
searchSheet style { onDismiss, search } =
    { onDismiss = Just onDismiss
    , content =
        search
            |> TextInput.textInput
                (style
                    |> Customize.elementRow
                        [ Element.width <| Element.fill
                        ]
                    |> Customize.mapContent
                        (\record ->
                            { record
                                | text =
                                    record.text
                            }
                        )
                )
            |> Element.el
                [ Element.alignTop
                , Element.width <| Element.fill
                ]
    }


{-| Material design only allows one element at a time to be visible as modal.

The order from most important to least important is as follows:

1.  dialog
2.  top sheet
3.  bottom sheet
4.  left sheet
5.  right sheet

-}
orderModals :
    { dialog : Maybe (Modal context theme msg)
    , topSheet : Maybe (Modal context theme msg)
    , bottomSheet : Maybe (Modal context theme msg)
    , leftSheet : Maybe (Modal context theme msg)
    , rightSheet : Maybe (Modal context theme msg)
    }
    -> List (Modal context theme msg)
orderModals modals =
    [ modals.dialog
    , modals.leftSheet
    , modals.rightSheet
    , modals.topSheet
    ]
        |> List.filterMap identity
