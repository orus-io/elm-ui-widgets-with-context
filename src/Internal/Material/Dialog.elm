module Internal.Material.Dialog exposing (alertDialog)

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Internal.Context exposing (Context)
import Internal.Dialog exposing (DialogStyle)
import Internal.Material.Button as Button
import Internal.Material.Context exposing (..)
import Internal.Material.Palette exposing (Palette)
import Widget.Material.Color as MaterialColor
import Widget.Material.Typography as Typography


alertDialog : DialogStyle context Theme msg
alertDialog =
    { elementColumn =
        [ Border.rounded 4
        , Element.fill
            |> Element.maximum 560
            |> Element.minimum 280
            |> Element.width
        , Element.height <| Element.minimum 182 <| Element.shrink
        , Background.color |> withSurfaceAttribute MaterialColor.fromColor
        ]
    , content =
        { title =
            { contentText =
                Typography.h6
                    ++ [ Element.paddingEach
                            { top = 20
                            , right = 24
                            , bottom = 0
                            , left = 24
                            }
                       ]
            }
        , text =
            { contentText =
                [ Element.paddingEach
                    { top = 20
                    , right = 24
                    , bottom = 0
                    , left = 24
                    }
                ]
            }
        , buttons =
            { elementRow =
                [ Element.paddingXY 8 8
                , Element.spacing 8
                , Element.alignRight
                , Element.alignBottom
                ]
            , content =
                { accept = Button.containedButton
                , dismiss = Button.textButton
                }
            }
        }
    }
