module Widget exposing
    ( ButtonStyle, Button, TextButton, iconButton, textButton, button
    , SwitchStyle, Switch, switch
    , Select, selectButton, select, toggleButton
    , MultiSelect, multiSelect
    , Modal, singleModal, multiModal
    , DialogStyle, Dialog, dialog
    , RowStyle, row, buttonRow, toggleRow, wrappedButtonRow
    , ColumnStyle, column, buttonColumn
    , ItemStyle, Item
    , FullBleedItemStyle, fullBleedItem
    , InsetItem, InsetItemStyle, insetItem
    , ExpansionItemStyle, ExpansionItem, expansionItem
    , ImageItemStyle, ImageItem, imageItem
    , MultiLineItemStyle, MultiLineItem, multiLineItem
    , HeaderStyle, headerItem
    , DividerStyle, divider
    , selectItem, asItem
    , itemList
    , AppBarStyle, menuBar, tabBar
    , SortTableStyle, SortTable, Column, sortTable, floatColumn, intColumn, stringColumn, unsortableColumn
    , TextInputStyle, TextInput, textInput
    , PasswordInputStyle, PasswordInput, newPasswordInput, currentPasswordInput
    , TabStyle, Tab, tab
    , ProgressIndicatorStyle, ProgressIndicator, circularProgressIndicator
    , Attribute, Context, Element, Label, Placeholder
    )

{-| This module contains different stateless view functions. No wiring required.

    Widget.button Material.primaryButton
        { text = "disable me"
        , icon =
            FeatherIcons.slash
                |> FeatherIcons.withSize 16
                |> FeatherIcons.toHtml []
                |> Element.html
                |> Element.el []
        , onPress =
            if isButtonEnabled then
                ChangedButtonStatus False
                    |> Just

            else
                Nothing
        }

Every widgets comes with a type. You can think of the widgets as building blocks.
You can create you own widgets by sticking widgets types together.


# Buttons

![Button](https://orasund.github.io/elm-ui-widgets/assets/button.png)

@docs ButtonStyle, Button, TextButton, iconButton, textButton, button


# Switch

![Switch](https://orasund.github.io/elm-ui-widgets/assets/switch.png)

@docs SwitchStyle, Switch, switch


# Select

![Select](https://orasund.github.io/elm-ui-widgets/assets/select.png)

@docs Select, selectButton, select, toggleButton

![MultiSelect](https://orasund.github.io/elm-ui-widgets/assets/multiSelect.png)

@docs MultiSelect, multiSelect


# Modal

![Modal](https://orasund.github.io/elm-ui-widgets/assets/modal.png)

@docs Modal, singleModal, multiModal


# Dialog

![Dialog](https://orasund.github.io/elm-ui-widgets/assets/dialog.png)

@docs DialogStyle, Dialog, dialog


# List

![List](https://orasund.github.io/elm-ui-widgets/assets/list.png)


## Row

@docs RowStyle, row, buttonRow, toggleRow, wrappedButtonRow


## Column

@docs ColumnStyle, column, buttonColumn


## Item

@docs ItemStyle, Item
@docs FullBleedItemStyle, fullBleedItem
@docs InsetItem, InsetItemStyle, insetItem
@docs ExpansionItemStyle, ExpansionItem, expansionItem
@docs ImageItemStyle, ImageItem, imageItem
@docs MultiLineItemStyle, MultiLineItem, multiLineItem
@docs HeaderStyle, headerItem
@docs DividerStyle, divider
@docs selectItem, asItem
@docs itemList


# App Bar

![App Bar](https://orasund.github.io/elm-ui-widgets/assets/appBar.png)

@docs AppBarStyle, menuBar, tabBar


# Sort Table

![Sort Table](https://orasund.github.io/elm-ui-widgets/assets/sortTable.png)

@docs SortTableStyle, SortTable, Column, sortTable, floatColumn, intColumn, stringColumn, unsortableColumn


# Text Input

![textInput](https://orasund.github.io/elm-ui-widgets/assets/textInput.png)

@docs TextInputStyle, TextInput, textInput
@docs PasswordInputStyle, PasswordInput, newPasswordInput, currentPasswordInput


# Tab

![tab](https://orasund.github.io/elm-ui-widgets/assets/tab.png)

@docs TabStyle, Tab, tab


# Progress Indicator

![progress Indicator](https://orasund.github.io/elm-ui-widgets/assets/progressIndicator.png)

@docs ProgressIndicatorStyle, ProgressIndicator, circularProgressIndicator

-}

import Color exposing (Color)
import Element.WithContext as Element exposing (DeviceClass, Length)
import Element.WithContext.Input as Input
import Internal.AppBar as AppBar
import Internal.Button as Button
import Internal.Dialog as Dialog
import Internal.Item as Item
import Internal.List as List
import Internal.Modal as Modal
import Internal.PasswordInput as PasswordInput
import Internal.ProgressIndicator as ProgressIndicator
import Internal.Select as Select
import Internal.SortTable as SortTable
import Internal.Switch as Switch
import Internal.Tab as Tab
import Internal.TextInput as TextInput
import Set exposing (Set)
import Widget.Icon exposing (Icon)


type alias Context context =
    { context
        | device : Element.Device
    }


type alias Attribute context msg =
    Element.Attribute (Context context) msg


type alias Element context msg =
    Element.Element (Context context) msg


type alias Placeholder context msg =
    Input.Placeholder (Context context) msg


type alias Label context msg =
    Input.Label (Context context) msg



{----------------------------------------------------------
- ICON
----------------------------------------------------------}


{-| -}
type alias IconStyle context =
    { size : Int
    , color : Context context -> Color
    }


type alias Icon context msg =
    { size : Int
    , color : Context context -> Color
    }
    -> Element context msg



{----------------------------------------------------------
- BUTTON
----------------------------------------------------------}


{-| -}
type alias ButtonStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , ifActive : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { text : { contentText : List (Attribute context msg) }
            , icon :
                { ifDisabled : IconStyle context
                , ifActive : IconStyle context
                , otherwise : IconStyle context
                }
            }
        }
    }


{-| Button widget type
-}
type alias Button context msg =
    { text : String
    , icon : Icon context msg
    , onPress : Maybe msg
    }


{-| Button widget type with no icon
-}
type alias TextButton msg =
    { text : String
    , onPress : Maybe msg
    }


{-| A button containing only an icon, the text is used for screenreaders.

    import Widget.Material as Material
    import Material.Icons as MaterialIcons
    import Material.Icons.Types exposing (Coloring(..))
    import Widget.Icon as Icon

    type Msg
        = Like

    iconButton (Material.iconButton Material.defaultPalette)
        { text = "Like"
        , icon = MaterialIcons.favorite |> Icon.elmMaterialIcons Color
        , onPress = Just Like
        }
        |> always "Ignore this line" --> "Ignore this line"

-}
iconButton :
    ButtonStyle context msg
    ->
        { text : String
        , icon : Icon context msg
        , onPress : Maybe msg
        }
    -> Element context msg
iconButton =
    let
        fun : ButtonStyle context msg -> Button context msg -> Element context msg
        fun =
            Button.iconButton
    in
    fun


{-| A button with just text and not icon.

    import Widget.Material as Material

    type Msg
        = Like

    textButton (Material.textButton Material.defaultPalette)
        { text = "Like"
        , onPress = Just Like
        }
        |> always "Ignore this line" --> "Ignore this line"

-}
textButton :
    ButtonStyle context msg
    ->
        { textButton
            | text : String
            , onPress : Maybe msg
        }
    -> Element context msg
textButton style { text, onPress } =
    let
        fun : ButtonStyle context msg -> TextButton msg -> Element context msg
        fun =
            Button.textButton
    in
    fun style
        { text = text
        , onPress = onPress
        }


{-| A button containing a text and an icon.

    import Widget.Material as Material
    import Material.Icons as MaterialIcons
    import Material.Icons.Types exposing (Coloring(..))
    import Widget.Icon as Icon

    type Msg
        = Submit

    button (Material.containedButton Material.defaultPalette)
        { text = "Submit"
        , icon = MaterialIcons.favorite |> Icon.elmMaterialIcons Color
        , onPress = Just Submit
        }
        |> always "Ignore this line" --> "Ignore this line"

-}
button :
    ButtonStyle context msg
    ->
        { text : String
        , icon : Icon context msg
        , onPress : Maybe msg
        }
    -> Element context msg
button =
    let
        fun : ButtonStyle context msg -> Button context msg -> Element context msg
        fun =
            Button.button
    in
    fun



{----------------------------------------------------------
- SWITCH
----------------------------------------------------------}


{-| -}
type alias SwitchStyle context msg =
    { elementButton : List (Attribute context msg)
    , content :
        { element : List (Attribute context msg)
        , ifDisabled : List (Attribute context msg)
        , ifActive : List (Attribute context msg)
        , otherwise : List (Attribute context msg)
        }
    , contentInFront :
        { element : List (Attribute context msg)
        , ifDisabled : List (Attribute context msg)
        , ifActive : List (Attribute context msg)
        , otherwise : List (Attribute context msg)
        , content :
            { element : List (Attribute context msg)
            , ifDisabled : List (Attribute context msg)
            , ifActive : List (Attribute context msg)
            , otherwise : List (Attribute context msg)
            }
        }
    }


{-| Switch widget type
-}
type alias Switch msg =
    { description : String
    , onPress : Maybe msg
    , active : Bool
    }


{-| A boolean switch

    import Widget.Material as Material

    type Msg
        = Activate

    switch (Material.switch Material.defaultPalette)
        { description = "Activate Dark Mode"
        , onPress = Just Activate
        , active = False
        }
        |> always "Ignore this line" --> "Ignore this line"

-}
switch :
    SwitchStyle context msg
    ->
        { description : String
        , onPress : Maybe msg
        , active : Bool
        }
    -> Element context msg
switch =
    let
        fun : SwitchStyle context msg -> Switch msg -> Element context msg
        fun =
            Switch.switch
    in
    fun



{----------------------------------------------------------
- SELECT
----------------------------------------------------------}


{-| Select widget type

Technical Remark:

  - A more suitable name would be "Choice"

-}
type alias Select context msg =
    { selected : Maybe Int
    , options :
        List
            { text : String
            , icon : Icon context msg
            }
    , onSelect : Int -> Maybe msg
    }


{-| Multi Select widget type

Technical Remark:

  - A more suitable name would be "Options"

-}
type alias MultiSelect context msg =
    { selected : Set Int
    , options :
        List
            { text : String
            , icon : Icon context msg
            }
    , onSelect : Int -> Maybe msg
    }


{-| A simple button that can be selected.

    import Widget.Material as Material
    import Element

    type Msg
        = ChangedSelected Int

    { selected = Just 1
    , options =
        [ 1, 2, 42 ]
            |> List.map
                (\int ->
                    { text = String.fromInt int
                    , icon = always Element.none
                    }
                )
    , onSelect = (\i -> Just <| ChangedSelected i)
    }
        |> Widget.select
        |> Widget.buttonRow
            { elementRow = Material.buttonRow
            , content = Material.outlinedButton Material.defaultPalette
            }
        |> always "Ignore this line" --> "Ignore this line"

-}
selectButton :
    ButtonStyle context msg
    -> ( Bool, Button context msg )
    -> Element context msg
selectButton =
    Select.selectButton


{-| A icon button that can be selected. Should be used together with Material.toggleButton

    import Widget.Material as Material
    import Element

    type Msg
        = ChangedSelected Int

    { selected = Just 1
    , options =
        [ 1, 2, 42 ]
            |> List.map
                (\int ->
                    { text = String.fromInt int
                    , icon = always Element.none
                    }
                )
    , onSelect = (\i -> Just <| ChangedSelected i)
    }
        |> Widget.select
        |> Widget.toggleRow
            { elementRow = Material.toggleRow
            , content = Material.toggleButton Material.defaultPalette
            }
        |> always "Ignore this line" --> "Ignore this line"

-}
toggleButton :
    ButtonStyle context msg
    -> ( Bool, Button context msg )
    -> Element context msg
toggleButton =
    Select.toggleButton


{-| Selects one out of multiple options. This can be used for radio buttons or Menus.

    import Widget.Material as Material
    import Element

    type Msg
        = ChangedSelected Int

    { selected = Just 1
    , options =
        [ 1, 2, 42 ]
            |> List.map
                (\int ->
                    { text = String.fromInt int
                    , icon = always Element.none
                    }
                )
    , onSelect = (\i -> Just <| ChangedSelected i)
    }
        |> Widget.select
        |> Widget.buttonRow
            { elementRow = Material.buttonRow
            , content = Material.toggleButton Material.defaultPalette
            }
        |> always "Ignore this line" --> "Ignore this line"

-}
select :
    Select context msg
    -> List ( Bool, Button context msg )
select =
    Select.select


{-| Selects multible options. This can be used for checkboxes.

    import Widget.Material as Material
    import Set
    import Element

    type Msg
        = ChangedSelected Int

    { selected = [1,2] |> Set.fromList
    , options =
        [ 1, 2, 42 ]
            |> List.map
                (\int ->
                    { text = String.fromInt int
                    , icon = always Element.none
                    }
                )
    , onSelect = (\i -> Just <| ChangedSelected i)
    }
        |> Widget.multiSelect
        |> Widget.buttonRow
            { elementRow = Material.buttonRow
            , content = Material.toggleButton Material.defaultPalette
            }
        |> always "Ignore this line" --> "Ignore this line"

-}
multiSelect :
    MultiSelect context msg
    -> List ( Bool, Button context msg )
multiSelect =
    Select.multiSelect



{----------------------------------------------------------
- MODAL
----------------------------------------------------------}


{-| -}
type alias Modal context msg =
    { onDismiss : Maybe msg
    , content : Element context msg
    }


{-| A modal showing a single element.

Material design only allows one element at a time to be viewed as a modal.
To make things easier, this widget only views the first element of the list.
This way you can see the list as a queue of modals.

    import Element

    type Msg
        = Close

    Element.layout
        (singleModal
            [ { onDismiss = Just Close
              , content =
                  Element.text "Click outside this window to close it."
              }
            ]
        )
        |> always "Ignore this line" --> "Ignore this line"

Technical Remark:

  - To stop the screen from scrolling, set the height of the layout to the height of the screen.

-}
singleModal : List { onDismiss : Maybe msg, content : Element context msg } -> List (Attribute context msg)
singleModal =
    Modal.singleModal


{-| Same implementation as `singleModal` but also displays the "queued" modals.

    import Element

    type Msg
        = Close

    Element.layout
        (multiModal
            [ { onDismiss = Just Close
              , content =
                  Element.text "Click outside this window to close it."
              }
            ]
        )
        |> always "Ignore this line" --> "Ignore this line"

-}
multiModal : List { onDismiss : Maybe msg, content : Element context msg } -> List (Attribute context msg)
multiModal =
    Modal.multiModal



{----------------------------------------------------------
- DIALOG
----------------------------------------------------------}


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


{-| Dialog widget type
-}
type alias Dialog msg =
    { title : Maybe String
    , text : String
    , accept : Maybe (TextButton msg)
    , dismiss : Maybe (TextButton msg)
    }


{-| A Dialog Window.

    import Widget.Material as Material
    import Element

    type Msg
        = Submit
        | Close

    Element.layout
        (dialog (Material.alertDialog Material.defaultPalette)
            { title = Just "Accept"
            , text = "Are you sure?"
            , accept =
                { text = "Accept"
                , onPress = Just Submit
                }
                |> Just
            , dismiss =
                { text = "Cancel"
                , onPress = Just Close
                }
                |> Just
            }
            |> List.singleton
            |> singleModal
        )
        |> always "Ignore this line" --> "Ignore this line"

-}
dialog :
    DialogStyle context msg
    ->
        { title : Maybe String
        , text : String
        , accept : Maybe (TextButton msg)
        , dismiss : Maybe (TextButton msg)
        }
    -> Modal context msg
dialog =
    let
        fun : DialogStyle context msg -> Dialog msg -> Modal context msg
        fun =
            Dialog.dialog
    in
    fun



{----------------------------------------------------------
- TEXT INPUT
----------------------------------------------------------}


{-| -}
type alias TextInputStyle context msg =
    { elementRow : List (Attribute context msg)
    , content :
        { chips :
            { elementRow : List (Attribute context msg)
            , content : ButtonStyle context msg
            }
        , text :
            { elementTextInput : List (Attribute context msg)
            }
        }
    }


{-| Text Input widget type
-}
type alias TextInput context msg =
    { chips : List (Button context msg)
    , text : String
    , placeholder : Maybe (Placeholder context msg)
    , label : String
    , onChange : String -> msg
    }


{-| A text Input that allows to include chips.

    import Element
    import Widget.Material as Material

    type Msg =
        ToggleTextInputChip String
        | SetTextInput String

    {text = "Hello World"}
        |> (\model ->
                { chips =
                    [ "Cat", "Fish", "Dog"]
                        |> List.map
                            (\string ->
                                { icon = always Element.none
                                , text = string
                                , onPress =
                                    string
                                        |> ToggleTextInputChip
                                        |> Just
                                }
                            )
                , text = model.text
                , placeholder = Nothing
                , label = "Chips"
                , onChange = SetTextInput
                }
            )
        |> Widget.textInput (Material.textInput Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
textInput :
    TextInputStyle context msg
    ->
        { chips : List (Button context msg)
        , text : String
        , placeholder : Maybe (Placeholder context msg)
        , label : String
        , onChange : String -> msg
        }
    -> Element context msg
textInput =
    let
        fun : TextInputStyle context msg -> TextInput context msg -> Element context msg
        fun =
            TextInput.textInput
    in
    fun


{-| -}
type alias PasswordInputStyle context msg =
    { elementRow : List (Attribute context msg)
    , content :
        { password :
            { elementPasswordInput : List (Attribute context msg)
            }
        }
    }


{-| Password Input widget type
-}
type alias PasswordInput context msg =
    { text : String
    , placeholder : Maybe (Placeholder context msg)
    , label : String
    , onChange : String -> msg
    , show : Bool
    }


{-| An input field that supports autofilling the current password
-}
currentPasswordInput : PasswordInputStyle context msg -> PasswordInput context msg -> Element context msg
currentPasswordInput =
    PasswordInput.currentPasswordInput


{-| An input field that supports autofilling the new password
-}
newPasswordInput : PasswordInputStyle context msg -> PasswordInput context msg -> Element context msg
newPasswordInput =
    PasswordInput.newPasswordInput



{----------------------------------------------------------
- LIST
----------------------------------------------------------}


{-| -}
type alias ItemStyle content context msg =
    { element : List (Attribute context msg)
    , content : content
    }


{-| -}
type alias DividerStyle context msg =
    { element : List (Attribute context msg)
    }


{-| -}
type alias HeaderStyle context msg =
    { elementColumn : List (Attribute context msg)
    , content :
        { divider : DividerStyle context msg
        , title : List (Attribute context msg)
        }
    }


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


{-| -}
type alias FullBleedItemStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { text : { elementText : List (Attribute context msg) }
            , icon : IconStyle context
            }
        }
    }


{-| -}
type alias InsetItemStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { text : { elementText : List (Attribute context msg) }
            , icon :
                { element : List (Attribute context msg)
                , content : IconStyle context
                }
            , content : IconStyle context
            }
        }
    }


{-| -}
type alias MultiLineItemStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { description :
                { elementColumn : List (Attribute context msg)
                , content :
                    { title : { elementText : List (Attribute context msg) }
                    , text : { elementText : List (Attribute context msg) }
                    }
                }
            , icon :
                { element : List (Attribute context msg)
                , content : IconStyle context
                }
            , content : IconStyle context
            }
        }
    }


{-| -}
type alias ImageItemStyle context msg =
    { elementButton : List (Attribute context msg)
    , ifDisabled : List (Attribute context msg)
    , otherwise : List (Attribute context msg)
    , content :
        { elementRow : List (Attribute context msg)
        , content :
            { text : { elementText : List (Attribute context msg) }
            , image : { element : List (Attribute context msg) }
            , content : IconStyle context
            }
        }
    }


{-| -}
type alias ExpansionItemStyle context msg =
    { item : ItemStyle (InsetItemStyle context msg) context msg
    , expandIcon : Icon context msg
    , collapseIcon : Icon context msg
    }


{-| -}
type alias InsetItem context msg =
    { text : String
    , onPress : Maybe msg
    , icon : Icon context msg
    , content : Icon context msg
    }


{-| -}
type alias MultiLineItem context msg =
    { title : String
    , text : String
    , onPress : Maybe msg
    , icon : Icon context msg
    , content : Icon context msg
    }


{-| -}
type alias ImageItem context msg =
    { text : String
    , onPress : Maybe msg
    , image : Element context msg
    , content : Icon context msg
    }


{-| -}
type alias ExpansionItem context msg =
    { icon : Icon context msg
    , text : String
    , onToggle : Bool -> msg
    , content : List (Item context msg)
    , isExpanded : Bool
    }


{-| Item widget type.

Use `Widget.asItem` if you want to turn a simple element into an item.

-}
type alias Item context msg =
    List (Attribute context msg) -> Element context msg


{-| A text item spanning the full width.

    import Element
    import Widget.Material as Material

    [ Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        }
    , Widget.divider (Material.fullBleedDivider Material.defaultPalette )
    , Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        }
    ]
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
fullBleedItem :
    ItemStyle (FullBleedItemStyle context msg) context msg
    ->
        { text : String
        , onPress : Maybe msg
        , icon : Icon context msg
        }
    -> Item context msg
fullBleedItem =
    let
        fun : ItemStyle (FullBleedItemStyle context msg) context msg -> Button context msg -> Item context msg
        fun =
            Item.fullBleedItem
    in
    fun


{-| Turns a Element into an item. Only use if you want to take care of the styling yourself.

    import Element
    import Widget.Material as Material

    Element.text "Just a text"
        |> Widget.asItem
        |> List.singleton
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
asItem : Element context msg -> Item context msg
asItem =
    Item.asItem


{-| A divider.

    import Element
    import Widget.Material as Material

    [ Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        }
    , Widget.divider (Material.insetDivider Material.defaultPalette )
    , Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        }
    ]
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
divider : ItemStyle (DividerStyle context msg) context msg -> Item context msg
divider =
    Item.divider


{-| A header for a part of a list.

    import Element
    import Widget.Material as Material

    [ Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        }
    , "Header"
        |> Widget.headerItem (Material.insetHeader Material.defaultPalette )
    , Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        }
    ]
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
headerItem : ItemStyle (HeaderStyle context msg) context msg -> String -> Item context msg
headerItem =
    Item.headerItem


{-| A clickable item that contains two spots for icons or additional information and a single line of text.

    import Element
    import Widget.Material as Material

    [ Widget.insetItem (Material.insetItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        , content = always Element.none
        }
    , Widget.divider (Material.insetDivider Material.defaultPalette )
    , Widget.insetItem (Material.insetItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        , content = always Element.none
        }
    ]
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
insetItem :
    ItemStyle (InsetItemStyle context msg) context msg
    ->
        { text : String
        , onPress : Maybe msg
        , icon : Icon context msg
        , content : Icon context msg
        }
    -> Item context msg
insetItem =
    let
        fun : ItemStyle (InsetItemStyle context msg) context msg -> InsetItem context msg -> Item context msg
        fun =
            Item.insetItem
    in
    fun


{-| A item contining a text running over multiple lines.

    import Element
    import Widget.Material as Material

    [ Widget.multiLineItem (Material.multiLineItem Material.defaultPalette)
        { title = "Title"
        , onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        , content = always Element.none
        }
    ]
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
multiLineItem :
    ItemStyle (MultiLineItemStyle context msg) context msg
    ->
        { title : String
        , text : String
        , onPress : Maybe msg
        , icon : Icon context msg
        , content : Icon context msg
        }
    -> Item context msg
multiLineItem =
    let
        fun : ItemStyle (MultiLineItemStyle context msg) context msg -> MultiLineItem context msg -> Item context msg
        fun =
            Item.multiLineItem
    in
    fun


{-| A clickable item that contains a image , a line of text and some additonal information

    import Element
    import Widget.Material as Material
    import Widget.Material.Color as MaterialColor
    import Element.Font as Font

    [ Widget.imageItem (Material.imageItem Material.defaultPalette)
        { onPress = Nothing
        , image =
            Element.image [ Element.width <| Element.px <| 40, Element.height <| Element.px <| 40 ]
                { src = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Elm_logo.svg/1024px-Elm_logo.svg.png"
                , description = "Elm logo"
                }
        , text = "Item with Image"
        , content =
            \{ size, color } ->
                "1."
                    |> Element.text
                    |> Element.el
                        [ Font.color <| MaterialColor.fromColor color
                        , Font.size size
                        ]
        }
    ]
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
imageItem :
    ItemStyle (ImageItemStyle context msg) context msg
    ->
        { text : String
        , onPress : Maybe msg
        , image : Element context msg
        , content : Icon context msg
        }
    -> Item context msg
imageItem =
    let
        fun : ItemStyle (ImageItemStyle context msg) context msg -> ImageItem context msg -> Item context msg
        fun =
            Item.imageItem
    in
    fun


{-| An expandable Item

    import Element
    import Widget.Material as Material

    type Msg =
        Toggle Bool

    let
        isExpanded : Bool
        isExpanded =
            True
    in
    (   ( Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
            { onPress = Nothing
            , icon = always Element.none
            , text = "Item with Icon"
            }
        )
        :: Widget.expansionItem (Material.expansionItem Material.defaultPalette )
            { onToggle = Toggle
            , isExpanded = isExpanded
            , icon = always Element.none
            , text = "Expandable Item"
            , content =
                [ Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
                { onPress = Nothing
                , icon = always Element.none
                , text = "Item with Icon"
                }
                ]
            }
    )
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
expansionItem :
    ExpansionItemStyle context msg
    ->
        { icon : Icon context msg
        , text : String
        , onToggle : Bool -> msg
        , content : List (Item context msg)
        , isExpanded : Bool
        }
    -> List (Item context msg)
expansionItem =
    let
        fun : ExpansionItemStyle context msg -> ExpansionItem context msg -> List (Item context msg)
        fun =
            Item.expansionItem
    in
    fun


{-| Displays a selection of Buttons as a item list. This is intended to be used as a menu.

    import Element
    import Widget.Material as Material

    type Msg =
        Select Int

    (   { selected = Just 1
        , options =
            [ "Option 1", "Option 2" ]
                |> List.map
                    (\text ->
                        { text = text
                        , icon = always Element.none
                        }
                    )
        , onSelect = (\int ->
            int
            |> Select
            |> Just
            )
        }
            |> Widget.selectItem (Material.selectItem Material.defaultPalette)
    )
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
selectItem : ItemStyle (ButtonStyle context msg) context msg -> Select context msg -> List (Item context msg)
selectItem =
    Item.selectItem


{-| Replacement of `Element.row`

    import Element
    import Widget.Material as Material

    [ Element.text "Text 1"
    , Element.text "Text 2"
    ]
        |> Widget.row Material.row
        |> always "Ignore this line" --> "Ignore this line"

-}
row : RowStyle context msg -> List (Element context msg) -> Element context msg
row =
    let
        fun : RowStyle context msg -> List (Element context msg) -> Element context msg
        fun =
            List.row
    in
    fun


{-| Replacement of `Element.column`

    import Element
    import Widget.Material as Material

    [ Element.text "Text 1"
    , Element.text "Text 2"
    ]
        |> Widget.column Material.column
        |> always "Ignore this line" --> "Ignore this line"

-}
column : ColumnStyle context msg -> List (Element context msg) -> Element context msg
column =
    let
        fun : ColumnStyle context msg -> List (Element context msg) -> Element context msg
        fun =
            List.column
    in
    fun


{-| Implementation of the Material design list

    import Element
    import Widget.Material as Material

    [ Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        }
    , "Header"
        |> Widget.headerItem (Material.insetHeader Material.defaultPalette )
    , Widget.fullBleedItem (Material.fullBleedItem Material.defaultPalette)
        { onPress = Nothing
        , icon = always Element.none
        , text = "Item"
        }
    ]
        |> Widget.itemList (Material.cardColumn Material.defaultPalette)
        |> always "Ignore this line" --> "Ignore this line"

-}
itemList : ColumnStyle context msg -> List (Item context msg) -> Element context msg
itemList =
    let
        fun : ColumnStyle context msg -> List (Item context msg) -> Element context msg
        fun =
            List.itemList
    in
    fun


{-| A row of buttons

    import Element
    import Widget.Material as Material

    type Msg =
        Select Int

    selected : Maybe Int
    selected =
        Just 0

    Widget.select
        { selected = selected
        , options =
            [ 1, 2, 42 ]
                |> List.map
                    (\int ->
                        { text = String.fromInt int
                        , icon = always Element.none
                        }
                    )
        , onSelect = (\i -> Just (Select i ))
        }
        |> Widget.buttonRow
            { elementRow = Material.row
            , content = Material.outlinedButton Material.defaultPalette
            }
        |> always "Ignore this line" --> "Ignore this line"

-}
buttonRow :
    { elementRow : RowStyle context msg
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> Element context msg
buttonRow =
    List.buttonRow


{-| A row of icon buttons use this in combination with Material.toggleButton

    import Element
    import Widget.Material as Material

    type Msg =
        Select Int

    selected : Maybe Int
    selected =
        Just 0

    Widget.select
        { selected = selected
        , options =
            [ 1, 2, 42 ]
                |> List.map
                    (\int ->
                        { text = String.fromInt int
                        , icon = always Element.none
                        }
                    )
        , onSelect = (\i -> Just (Select i ))
        }
        |> Widget.buttonRow
            { elementRow = Material.row
            , content = Material.toggleButton Material.defaultPalette
            }
        |> always "Ignore this line" --> "Ignore this line"

-}
toggleRow :
    { elementRow : RowStyle context msg
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> Element context msg
toggleRow =
    List.toggleRow


{-| A wrapped row of buttons

    import Element
    import Widget.Material as Material

    type Msg =
        Select Int

    selected : Maybe Int
    selected =
        Just 0

    Widget.select
        { selected = selected
        , options =
            [ 1, 2, 42 ]
                |> List.map
                    (\int ->
                        { text = String.fromInt int
                        , icon = always Element.none
                        }
                    )
        , onSelect = (\i -> Just (Select i ))
        }
        |> Widget.wrappedButtonRow
            { elementRow = Material.row
            , content = Material.outlinedButton Material.defaultPalette
            }
        |> always "Ignore this line" --> "Ignore this line"

-}
wrappedButtonRow :
    { elementRow : RowStyle context msg
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> Element context msg
wrappedButtonRow =
    List.wrappedButtonRow


{-| A column of buttons

    import Element
    import Widget.Material as Material

    type Msg =
        Select Int

    selected : Maybe Int
    selected =
        Just 0

    Widget.select
        { selected = selected
        , options =
            [ 1, 2, 42 ]
                |> List.map
                    (\int ->
                        { text = String.fromInt int
                        , icon = always Element.none
                        }
                    )
        , onSelect = (\i -> Just (Select i ))
        }
        |> Widget.buttonColumn
            { elementColumn = Material.column
            , content = Material.toggleButton Material.defaultPalette
            }
        |> always "Ignore this line" --> "Ignore this line"

-}
buttonColumn :
    { elementColumn : ColumnStyle context msg
    , content : ButtonStyle context msg
    }
    -> List ( Bool, Button context msg )
    -> Element context msg
buttonColumn =
    List.buttonColumn



--------------------------------------------------------------------------------
-- APP BAR
--------------------------------------------------------------------------------


{-| -}
type alias AppBarStyle content context msg =
    { elementRow : List (Attribute context msg)
    , content :
        { menu :
            { elementRow : List (Attribute context msg)
            , content : content
            }
        , search : TextInputStyle context msg
        , actions :
            { elementRow : List (Attribute context msg)
            , content :
                { button : ButtonStyle context msg
                , searchIcon : Icon context msg
                , moreVerticalIcon : Icon context msg
                }
            }
        }
    }


{-| A app bar with a menu button on the left side.

This should be the default way to display the app bar. Specially for Phone users.

    import Element exposing (DeviceClass(..))
    import Widget.Material as Material

    type Msg =
        Select Int

    selected : Int
    selected = 0

    Widget.menuBar style.tabBar
        { title =
            "Title"
                |> Element.text
                |> Element.el Typography.h6
        , deviceClass = Phone
        , openRightSheet = Nothing
        , openTopSheet = Nothing
        , primaryActions =
            [   { icon =
                    Material.Icons.change_history
                        |> Icon.elmMaterialIcons Color
                , text = "Action"
                , onPress = Nothing
                }
            ]
        , search = Nothing
        }

-}
menuBar :
    AppBarStyle
        { menuIcon : Icon context msg
        , title : List (Attribute context msg)
        }
        context
        msg
    ->
        { title : Element context msg
        , openLeftSheet : Maybe msg
        , openRightSheet : Maybe msg
        , openTopSheet : Maybe msg
        , primaryActions : List (Button context msg)
        , search : Maybe (TextInput context msg)
        }
    -> Element context msg
menuBar =
    AppBar.menuBar


{-| A app bar with tabs instead of a menu.

This is should be used for big screens.

It should be avoided for smaller screens or if you have more then 4 tabs

    import Element exposing (DeviceClass(..))
    import Widget.Material as Material

    type Msg =
        Select Int

    selected : Int
    selected = 0

    Widget.tabBar style.tabBar
        { title =
            "Title"
                |> Element.text
                |> Element.el Typography.h6
        , menu =
            { selected = Just selected
            , options =
                [ "Home", "About" ]
                    |> List.map
                        (\string ->
                            { text = string
                            , icon = always Element.none
                            }
                        )
            , onSelect = \int -> int |> Select |> Just
            }
        , deviceClass = Phone
        , openRightSheet = Nothing
        , openTopSheet = Nothing
        , primaryActions =
            [   { icon =
                    Material.Icons.change_history
                        |> Icon.elmMaterialIcons Color
                , text = "Action"
                , onPress = Nothing
                }
            ]
        , search = Nothing
        }

-}
tabBar :
    AppBarStyle
        { menuTabButton : ButtonStyle context msg
        , title : List (Attribute context msg)
        }
        context
        msg
    ->
        { title : Element context msg
        , menu : Select context msg
        , openRightSheet : Maybe msg
        , openTopSheet : Maybe msg
        , primaryActions : List (Button context msg)
        , search : Maybe (TextInput context msg)
        }
    -> Element context msg
tabBar =
    AppBar.tabBar



{----------------------------------------------------------
- SORT TABLE
----------------------------------------------------------}


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


{-| Column for the Sort Table widget type
-}
type alias Column a =
    SortTable.Column a


{-| Sort Table widget type
-}
type alias SortTable a msg =
    { content : List a
    , columns : List (Column a)
    , sortBy : String
    , asc : Bool
    , onChange : String -> msg
    }


{-| An unsortable Column, when trying to sort by this column, nothing will change.
-}
unsortableColumn :
    { title : String
    , toString : a -> String
    , width : Length
    }
    -> Column a
unsortableColumn =
    SortTable.unsortableColumn


{-| A Column containing a Int
-}
intColumn :
    { title : String
    , value : a -> Int
    , toString : Int -> String
    , width : Length
    }
    -> Column a
intColumn =
    SortTable.intColumn


{-| A Column containing a Float
-}
floatColumn :
    { title : String
    , value : a -> Float
    , toString : Float -> String
    , width : Length
    }
    -> Column a
floatColumn =
    SortTable.floatColumn


{-| A Column containing a String

`value >> toString` field will be used for displaying the content.

`value` will be used for comparing the content

For example `value = String.toLower` will make the sorting case-insensitive.

-}
stringColumn :
    { title : String
    , value : a -> String
    , toString : String -> String
    , width : Length
    }
    -> Column a
stringColumn =
    SortTable.stringColumn


{-| A table where the rows can be sorted by columns

    import Widget.Material as Material
    import Element

    type Msg =
        ChangedSorting String

    sortBy : String
    sortBy =
        "Id"

    asc : Bool
    asc =
        True

    Widget.sortTable (Material.sortTable Material.defaultPalette)
        { content =
            [ { id = 1, name = "Antonio", rating = 2.456, hash = Nothing }
            , { id = 2, name = "Ana", rating = 1.34, hash = Just "45jf" }
            , { id = 3, name = "Alfred", rating = 4.22, hash = Just "6fs1" }
            , { id = 4, name = "Thomas", rating = 3, hash = Just "k52f" }
            ]
        , columns =
            [ Widget.intColumn
                { title = "Id"
                , value = .id
                , toString = \int -> "#" ++ String.fromInt int
                , width = Element.fill
                }
            , Widget.stringColumn
                { title = "Name"
                , value = .name
                , toString = identity
                , width = Element.fill
                }
            , Widget.floatColumn
                { title = "Rating"
                , value = .rating
                , toString = String.fromFloat
                , width = Element.fill
                }
            , Widget.unsortableColumn
                { title = "Hash"
                , toString = (\{hash} -> hash |> Maybe.withDefault "None")
                , width = Element.fill
                }
            ]
        , asc = asc
        , sortBy = sortBy
        , onChange = ChangedSorting
        }
        |> always "Ignore this line" --> "Ignore this line"

-}
sortTable :
    SortTableStyle context msg
    ->
        { content : List a
        , columns : List (Column a)
        , sortBy : String
        , asc : Bool
        , onChange : String -> msg
        }
    -> Element context msg
sortTable =
    let
        fun : SortTableStyle context msg -> SortTable a msg -> Element context msg
        fun =
            SortTable.sortTable
    in
    fun



{----------------------------------------------------------
- TAB
----------------------------------------------------------}


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


{-| Tab widget type
-}
type alias Tab context msg =
    { tabs : Select context msg
    , content : Maybe Int -> Element context msg
    }


{-| Displayes a list of contents in a tab

    import Element
    import Widget.Material as Material

    type Msg =
        ChangedTab Int

    selected : Maybe Int
    selected =
        Just 0

    Widget.tab (Material.tab Material.defaultPalette)
        { tabs =
            { selected = selected
            , options =
                [ 1, 2, 3 ]
                    |> List.map
                        (\int ->
                            { text = "Tab " ++ (int |> String.fromInt)
                            , icon = always Element.none
                            }
                        )
            , onSelect =
                (\s ->
                    if s >= 0 && s <= 2 then
                        Just (ChangedTab s)
                    else
                        Nothing
                )
            }
        , content =
            (\s ->
                case s of
                    Just 0 ->
                        "This is Tab 1" |> Element.text
                    Just 1 ->
                        "This is the second tab" |> Element.text
                    Just 2 ->
                        "The thrid and last tab" |> Element.text
                    _ ->
                        "Please select a tab" |> Element.text
            )
        }
        |> always "Ignore this line" --> "Ignore this line"

-}
tab :
    TabStyle context msg
    ->
        { tabs : Select context msg
        , content : Maybe Int -> Element context msg
        }
    -> Element context msg
tab =
    let
        fun : TabStyle context msg -> Tab context msg -> Element context msg
        fun =
            Tab.tab
    in
    fun



{----------------------------------------------------------
- PROGRESS INDICATOR
----------------------------------------------------------}


{-| -}
type alias ProgressIndicatorStyle context msg =
    { elementFunction : Maybe Float -> Element context msg
    }


{-| Progress Indicator widget type

If `maybeProgress` is set to `Nothing`, an indeterminate progress indicator (e.g. spinner) will display.
If `maybeProgress` is set to `Just Float` (where the `Float` is proportion of completeness between 0 and 1 inclusive), a determinate progress indicator will visualize the progress.

-}
type alias ProgressIndicator =
    Maybe Float


{-| Displays a circular progress indicator

    import Widget.Material as Material

    Just 0.75
    |> Widget.circularProgressIndicator (Material.progressIndicator Material.defaultPalette)
    |> always "Ignore this line" --> "Ignore this line"

-}
circularProgressIndicator :
    ProgressIndicatorStyle context msg
    -> Maybe Float
    -> Element context msg
circularProgressIndicator =
    ProgressIndicator.circularProgressIndicator
