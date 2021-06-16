module Internal.Material.Snackbar exposing (snackbar)

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Internal.Context exposing (Context)
import Internal.Material.Button as Button
import Widget.Material.Context exposing (..)
import Internal.Material.Palette exposing (Palette)
import Widget.Customize as Customize
import Widget.Material.Color as MaterialColor
import Widget.Snackbar exposing (SnackbarStyle)


snackbar : SnackbarStyle context Palette msg
snackbar =
    { elementRow =
        [ MaterialColor.dark
            |> MaterialColor.fromColor
            |> Background.color
        , MaterialColor.dark
            |> MaterialColor.accessibleTextColor
            |> MaterialColor.fromColor
            |> Font.color
        , Border.rounded 4
        , Element.width <| Element.maximum 344 <| Element.fill
        , Element.paddingXY 8 6
        , Element.spacing 8
        , Border.shadow <| MaterialColor.shadow 2
        ]
    , content =
        { text =
            { elementText =
                [ Element.centerX
                , Element.paddingXY 10 8
                ]
            }
        , button =
            Button.textButton
                |> Customize.elementButton
                    [ withPrimaryAttribute
                        (\primary ->
                            MaterialColor.dark
                                |> MaterialColor.accessibleWithTextColor primary
                                |> MaterialColor.fromColor
                        )
                        Font.color
                    ]
        }
    }
