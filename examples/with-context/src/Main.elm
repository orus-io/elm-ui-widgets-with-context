module Main exposing (main)

import Browser
import Element.WithContext as Element
import Widget
import Widget.Material as Material
import Widget.Material.Color as MaterialColor


type alias Context =
    { theme : Material.Palette
    , device : Element.Device
    }


type alias Element msg =
    Element.Element Context msg


type alias Attribute msg =
    Element.Attribute Context msg


type alias Attr decorative msg =
    Element.Attr Context decorative msg


main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type Msg
    = Noop


type alias Model =
    { uiContext : Context }


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { uiContext =
            { theme = Material.darkPalette
            , device = Element.classifyDevice { height = 800, width = 1200 }
            }
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Elm-UI-WithContext"
    , body =
        [ Element.layout model.uiContext
            (MaterialColor.textAndBackground (.theme >> .surface))
            (rootView model)
        ]
    }


rootView : Model -> Element Msg
rootView model =
    Element.column [ Element.width Element.fill ]
        [ Widget.menuBar Material.menuBar
            { title = Element.text "hi"
            , openLeftSheet = Nothing
            , openRightSheet = Nothing
            , openTopSheet = Nothing
            , primaryActions = []
            , search = Nothing
            }
        ]
