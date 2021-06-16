module Internal.Material.PasswordInput exposing (passwordInput, passwordInputBase)

import Element.WithContext as Element
import Element.WithContext.Border as Border
import Internal.Context exposing (Context)
import Widget.Material.Context exposing (..)
import Internal.Material.Palette exposing (Palette)
import Internal.PasswordInput exposing (PasswordInputStyle)
import Widget.Material.Color as MaterialColor


passwordInput : PasswordInputStyle context Palette msg
passwordInput =
    { elementRow =
        (getSurfaceColor
            |> MaterialColor.textAndBackground
        )
            ++ [ Element.spacing 8
               , Element.paddingXY 8 0
               , Border.width 1
               , Border.rounded 4
               , withOnSurfaceAttribute
                    (MaterialColor.scaleOpacity 0.14
                        >> MaterialColor.fromColor
                    )
                    Border.color
               , Element.focused
                    [ Border.shadow <| MaterialColor.shadow 4
                    , withPrimaryDecoration
                        MaterialColor.fromColor
                        Border.color
                    ]
               , Element.mouseOver [ Border.shadow <| MaterialColor.shadow 2 ]
               , Element.width <| Element.px <| 280
               ]
    , content =
        { password =
            { elementPasswordInput =
                (getSurfaceColor
                    |> MaterialColor.textAndBackground
                )
                    ++ [ Border.width 0
                       , Element.mouseOver []
                       , Element.focused []
                       , Element.centerY
                       ]
            }
        }
    }


passwordInputBase : PasswordInputStyle context Palette msg
passwordInputBase =
    { elementRow =
        getSurfaceColor
            |> MaterialColor.textAndBackground
    , content =
        { password =
            { elementPasswordInput =
                (getSurfaceColor
                    |> MaterialColor.textAndBackground
                )
                    ++ [ Border.width 0
                       , Element.mouseOver []
                       , Element.focused []
                       ]
            }
        }
    }
