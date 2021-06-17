module Internal.AppBar exposing (AppBarStyle, menuBar, tabBar)

import Element.WithContext as Element exposing (DeviceClass(..))
import Element.WithContext.Input as Input
import Internal.Button as Button exposing (Button, ButtonStyle)
import Internal.Context exposing (Attribute, Element)
import Internal.Select as Select exposing (Select)
import Internal.TextInput as TextInput exposing (TextInput, TextInputStyle)
import Widget.Customize as Customize
import Widget.Icon exposing (Icon)


type alias AppBarStyle content context msg =
    { elementRow : List (Attribute context msg) --header
    , content :
        { menu :
            { elementRow : List (Attribute context msg)
            , content : content
            }
        , search : TextInputStyle context msg --search
        , actions :
            { elementRow : List (Attribute context msg)
            , content :
                { button : ButtonStyle context msg --menuButton
                , searchIcon : Icon context msg
                , moreVerticalIcon : Icon context msg
                }
            }
        }
    }


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
menuBar style m =
    internalNav
        [ Button.iconButton style.content.actions.content.button
            { onPress = m.openLeftSheet
            , icon = style.content.menu.content.menuIcon
            , text = "Menu"
            }
        , m.title |> Element.el style.content.menu.content.title
        ]
        { elementRow = style.elementRow
        , content =
            { menu =
                { elementRow = style.content.menu.elementRow
                }
            , search = style.content.search
            , actions = style.content.actions
            }
        }
        m


{-| A top bar that displays the menu as tabs
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
tabBar style m =
    internalNav
        [ m.title |> Element.el style.content.menu.content.title
        , m.menu
            |> Select.select
            |> List.map (Select.selectButton style.content.menu.content.menuTabButton)
            |> Element.row
                [ Element.width <| Element.shrink
                ]
        ]
        { elementRow = style.elementRow
        , content =
            { menu =
                { elementRow = style.content.menu.elementRow
                }
            , search = style.content.search
            , actions = style.content.actions
            }
        }
        m


{-| -}
internalNav :
    List (Element context msg)
    ->
        { elementRow : List (Attribute context msg) --header
        , content :
            { menu :
                { elementRow : List (Attribute context msg)
                }
            , search : TextInputStyle context msg --search
            , actions :
                { elementRow : List (Attribute context msg)
                , content :
                    { button : ButtonStyle context msg --menuButton
                    , searchIcon : Icon context msg
                    , moreVerticalIcon : Icon context msg
                    }
                }
            }
        }
    ->
        { model
            | openRightSheet : Maybe msg
            , openTopSheet : Maybe msg
            , primaryActions : List (Button context msg)
            , search : Maybe (TextInput context msg)
        }
    -> Element context msg
internalNav menuElements style { openRightSheet, openTopSheet, primaryActions, search } =
    Element.with
        (\{ device } ->
            [ menuElements
                |> Element.row style.content.menu.elementRow
            , if device.class == Phone || device.class == Tablet then
                Element.none

              else
                search
                    |> Maybe.map
                        (\{ onChange, text, label } ->
                            TextInput.textInput style.content.search
                                { chips = []
                                , onChange = onChange
                                , text = text
                                , placeholder =
                                    Just <|
                                        Input.placeholder [] <|
                                            Element.text label
                                , label = label
                                }
                        )
                    |> Maybe.withDefault Element.none
            , [ search
                    |> Maybe.map
                        (\{ label } ->
                            if device.class == Tablet then
                                [ Button.button
                                    (style.content.actions.content.button
                                        --FIX FOR ISSUE #30
                                        |> Customize.elementButton [ Element.width Element.shrink ]
                                    )
                                    { onPress = openTopSheet
                                    , icon = style.content.actions.content.searchIcon
                                    , text = label
                                    }
                                ]

                            else if device.class == Phone then
                                [ Button.iconButton style.content.actions.content.button
                                    { onPress = openTopSheet
                                    , icon = style.content.actions.content.searchIcon
                                    , text = label
                                    }
                                ]

                            else
                                []
                        )
                    |> Maybe.withDefault []
              , primaryActions
                    |> List.map
                        (if device.class == Phone then
                            Button.iconButton style.content.actions.content.button

                         else
                            Button.button
                                (style.content.actions.content.button
                                    --FIX FOR ISSUE #30
                                    |> Customize.elementButton [ Element.width Element.shrink ]
                                )
                        )
              , case openRightSheet of
                    Nothing ->
                        []

                    Just _ ->
                        [ Button.iconButton style.content.actions.content.button
                            { onPress = openRightSheet
                            , icon = style.content.actions.content.moreVerticalIcon
                            , text = "More"
                            }
                        ]
              ]
                |> List.concat
                |> Element.row style.content.actions.elementRow
            ]
        )
        (Element.row
            (style.elementRow
                ++ [ Element.alignTop
                   , Element.width <| Element.fill
                   ]
            )
        )
