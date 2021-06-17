module Internal.Material.Chip exposing (chip)

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Internal.Button exposing (ButtonStyle)
import Internal.Material.Button as Button
import Internal.Material.Palette as Palette exposing (Palette)
import Widget.Material.Color as MaterialColor
import Widget.Material.Context exposing (..)


chip : ButtonStyle (Context context) msg
chip =
    { elementButton =
        [ Element.height <| Element.px 32
        , Element.paddingEach
            { top = 0
            , right = 12
            , bottom = 0
            , left = 4
            }
        , Border.rounded <| 16
        , Element.mouseDown <|
            [ withPaletteDecoration
                (\palette ->
                    Palette.lightGray palette
                        |> MaterialColor.withShade palette.on.surface MaterialColor.buttonPressedOpacity
                        |> MaterialColor.fromColor
                )
                Background.color
            ]
        , Element.focused <|
            [ withPaletteDecoration
                (\palette ->
                    Palette.lightGray palette
                        |> MaterialColor.withShade palette.on.surface MaterialColor.buttonFocusOpacity
                        |> MaterialColor.fromColor
                )
                Background.color
            ]
        , Element.mouseOver <|
            [ withPaletteDecoration
                (\palette ->
                    Palette.lightGray palette
                        |> MaterialColor.withShade palette.on.surface MaterialColor.buttonHoverOpacity
                        |> MaterialColor.fromColor
                )
                Background.color
            ]
        ]
    , ifDisabled =
        (Button.baseButton |> .ifDisabled)
            ++ MaterialColor.textAndBackground
                (\{ material } ->
                    Palette.lightGray material
                        |> MaterialColor.withShade material.on.surface MaterialColor.buttonDisabledOpacity
                )
            ++ [ Element.mouseDown []
               , Element.mouseOver []
               , Element.focused []
               ]
    , ifActive =
        [ withPaletteAttribute
            (\palette ->
                Palette.lightGray palette
                    |> MaterialColor.withShade palette.on.surface MaterialColor.buttonSelectedOpacity
                    |> MaterialColor.fromColor
            )
            Background.color
        , withPaletteAttribute
            (Palette.lightGray
                >> MaterialColor.accessibleTextColor
                >> MaterialColor.fromColor
            )
            Font.color
        , Border.shadow <| MaterialColor.shadow 4
        ]
    , otherwise =
        [ withPaletteAttribute
            (Palette.lightGray
                >> MaterialColor.fromColor
            )
            Background.color
        , withPaletteAttribute
            (Palette.lightGray
                >> MaterialColor.accessibleTextColor
                >> MaterialColor.fromColor
            )
            Font.color
        ]
    , content =
        { elementRow =
            [ Element.spacing 8
            , Element.paddingEach
                { top = 0
                , right = 0
                , bottom = 0
                , left = 8
                }
            , Element.centerY
            ]
        , content =
            { text =
                { contentText =
                    []
                }
            , icon =
                { ifActive =
                    { size = 18
                    , color =
                        getPalette
                            >> Palette.lightGray
                            >> MaterialColor.accessibleTextColor
                    }
                , ifDisabled =
                    { size = 18
                    , color =
                        getPalette
                            >> Palette.lightGray
                            >> MaterialColor.accessibleTextColor
                    }
                , otherwise =
                    { size = 18
                    , color =
                        getPalette
                            >> Palette.lightGray
                            >> MaterialColor.accessibleTextColor
                    }
                }
            }
        }
    }
