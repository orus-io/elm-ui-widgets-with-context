module Internal.Material.Switch exposing (switch)

import Color
import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Html.Attributes as Attributes
import Internal.Material.Palette as Palette exposing (Palette)
import Internal.Switch exposing (SwitchStyle)
import Widget.Material.Color as MaterialColor
import Widget.Material.Context exposing (..)


switch : SwitchStyle (Context context) msg
switch =
    { elementButton =
        [ Element.height <| Element.px 38
        , Element.width <| Element.px <| 58 - 18
        , Element.mouseDown []
        , Element.focused []
        , Element.mouseOver []
        ]
    , content =
        { element =
            [ Element.height <| Element.px 14
            , Element.width <| Element.px 34
            , Element.centerY
            , Element.centerX
            , Border.rounded <| 10
            ]
        , ifDisabled =
            [ Element.htmlAttribute <| Attributes.style "cursor" "not-allowed"
            , withPaletteAttribute
                (\palette ->
                    palette.surface
                        |> MaterialColor.withShade (Palette.gray palette)
                            (0.5 * MaterialColor.buttonDisabledOpacity)
                        |> MaterialColor.fromColor
                )
                Background.color
            ]
        , ifActive =
            [ withPrimaryAttribute
                (MaterialColor.scaleOpacity 0.5
                    >> MaterialColor.fromColor
                )
                Background.color
            ]
        , otherwise =
            [ withPaletteAttribute
                (Palette.gray
                    >> MaterialColor.scaleOpacity 0.5
                    >> MaterialColor.fromColor
                )
                Background.color
            ]
        }
    , contentInFront =
        { element =
            [ Element.height <| Element.px 38
            , Element.width <| Element.px 38
            , Border.rounded <| 19
            ]
        , ifDisabled =
            [ Element.htmlAttribute <| Attributes.style "cursor" "not-allowed" ]
        , ifActive =
            [ Element.mouseDown
                [ withPrimaryDecoration
                    (MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.focused
                [ withPrimaryDecoration
                    (MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.mouseOver
                [ withPrimaryDecoration
                    (MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , Element.alignRight
            , Element.moveRight 8
            ]
        , otherwise =
            [ Element.mouseDown
                [ Color.gray
                    |> MaterialColor.scaleOpacity MaterialColor.buttonPressedOpacity
                    |> MaterialColor.fromColor
                    |> Background.color
                ]
            , Element.focused
                [ Color.gray
                    |> MaterialColor.scaleOpacity MaterialColor.buttonFocusOpacity
                    |> MaterialColor.fromColor
                    |> Background.color
                ]
            , Element.mouseOver
                [ Color.gray
                    |> MaterialColor.scaleOpacity MaterialColor.buttonHoverOpacity
                    |> MaterialColor.fromColor
                    |> Background.color
                ]
            , Element.alignLeft
            , Element.moveLeft 8
            ]
        , content =
            { element =
                [ Element.height <| Element.px 20
                , Element.width <| Element.px 20
                , Element.centerY
                , Element.centerX
                , Border.rounded <| 10
                , Border.shadow <| MaterialColor.shadow 2
                , withSurfaceAttribute
                    MaterialColor.fromColor
                    Background.color
                ]
            , ifDisabled =
                [ withSurfaceAttribute
                    (MaterialColor.withShade Color.gray MaterialColor.buttonDisabledOpacity
                        >> MaterialColor.fromColor
                    )
                    Background.color
                , Element.mouseDown []
                , Element.mouseOver []
                , Element.focused []
                ]
            , ifActive =
                [ withPaletteAttribute
                    (\palette ->
                        palette.primary
                            |> MaterialColor.withShade palette.on.primary MaterialColor.buttonHoverOpacity
                            |> MaterialColor.fromColor
                    )
                    Background.color
                ]
            , otherwise =
                [ withPaletteAttribute
                    (\palette ->
                        palette.surface
                            |> MaterialColor.withShade palette.on.surface MaterialColor.buttonHoverOpacity
                            |> MaterialColor.fromColor
                    )
                    Background.color
                ]
            }
        }
    }
