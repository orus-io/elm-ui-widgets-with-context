module Internal.Material.List exposing
    ( bottomSheet
    , cardColumn
    , column
    , row
    , sideSheet
    , toggleRow
    )

import Element.WithContext as Element
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Internal.List exposing (ColumnStyle, RowStyle)
import Internal.Material.Palette as Palette exposing (Palette)
import Widget.Material.Color as MaterialColor
import Widget.Material.Context exposing (..)


row : RowStyle (Context context) msg
row =
    { elementRow =
        [ Element.paddingXY 0 8
        , Element.spacing 8
        ]
    , content =
        { element = []
        , ifSingleton = []
        , ifFirst = []
        , ifLast = []
        , otherwise = []
        }
    }


column : ColumnStyle (Context context) msg
column =
    { elementColumn =
        [ Element.paddingXY 0 8
        , Element.spacing 8
        ]
    , content =
        { element = []
        , ifSingleton = []
        , ifFirst = []
        , ifLast = []
        , otherwise = []
        }
    }


toggleRow : RowStyle (Context context) msg
toggleRow =
    { elementRow = []
    , content =
        { element = []
        , ifSingleton =
            [ Border.rounded 2
            ]
        , ifFirst =
            [ Border.roundEach
                { topLeft = 2
                , topRight = 0
                , bottomLeft = 2
                , bottomRight = 0
                }
            ]
        , ifLast =
            [ Border.roundEach
                { topLeft = 0
                , topRight = 2
                , bottomLeft = 0
                , bottomRight = 2
                }
            ]
        , otherwise =
            [ Border.rounded 0
            ]
        }
    }


cardColumn : ColumnStyle (Context context) msg
cardColumn =
    { elementColumn =
        [ Element.width <| Element.fill
        , Element.mouseOver <|
            [ Border.shadow <| MaterialColor.shadow 4 ]
        , Element.alignTop
        , Border.rounded 4
        , Border.width 1
        , withOnSurfaceAttribute
            (MaterialColor.scaleOpacity 0.14
                >> MaterialColor.fromColor
            )
            Border.color
        ]
    , content =
        { element =
            [ Element.paddingXY 16 12

            -- HOTFIX FOR ISSUE #52
            --, Element.height <| Element.minimum 48 <| Element.shrink
            , withSurfaceAttribute
                MaterialColor.fromColor
                Background.color
            , withSurfaceAttribute
                (MaterialColor.accessibleTextColor
                    >> MaterialColor.fromColor
                )
                Font.color
            , withOnSurfaceAttribute
                (MaterialColor.scaleOpacity 0.14
                    >> MaterialColor.fromColor
                )
                Border.color
            , Element.width <| Element.minimum 344 <| Element.fill
            ]
        , ifSingleton =
            [ Border.rounded 4
            , Border.width 1
            ]
        , ifFirst =
            [ Border.roundEach
                { topLeft = 4
                , topRight = 4
                , bottomLeft = 0
                , bottomRight = 0
                }
            ]
        , ifLast =
            [ Border.roundEach
                { topLeft = 0
                , topRight = 0
                , bottomLeft = 4
                , bottomRight = 4
                }
            ]
        , otherwise =
            [ Border.rounded 0
            ]
        }
    }


sideSheet : ColumnStyle (Context context) msg
sideSheet =
    { elementColumn =
        (getSurfaceColor |> MaterialColor.textAndBackground)
            ++ [ Element.width <| Element.maximum 360 <| Element.fill
               , Element.height <| Element.fill
               , Element.paddingXY 0 8
               , withPaletteAttribute
                    (Palette.gray
                        >> MaterialColor.fromColor
                    )
                    Border.color
               ]
    , content =
        { element =
            [ Element.width <| Element.fill
            , withPaletteAttribute
                (Palette.gray
                    >> MaterialColor.fromColor
                )
                Border.color
            ]
        , ifSingleton = []
        , ifFirst = []
        , ifLast = []
        , otherwise = []
        }
    }


bottomSheet : ColumnStyle (Context context) msg
bottomSheet =
    { elementColumn =
        (getSurfaceColor |> MaterialColor.textAndBackground)
            ++ [ Element.height <| Element.fill
               , Element.width <| Element.maximum 360 <| Element.fill
               , Element.paddingXY 0 8
               ]
    , content =
        { element =
            [ Element.width <| Element.fill ]
        , ifSingleton = []
        , ifFirst = []
        , ifLast = []
        , otherwise = []
        }
    }
