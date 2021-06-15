module Internal.ProgressIndicator exposing (ProgressIndicatorStyle, circularProgressIndicator)

import Internal.Context exposing (Element)


{-| -}
type alias ProgressIndicatorStyle context theme msg =
    { elementFunction : Maybe Float -> Element context theme msg
    }


circularProgressIndicator :
    ProgressIndicatorStyle context theme msg
    -> Maybe Float
    -> Element context theme msg
circularProgressIndicator style maybeProgress =
    style.elementFunction maybeProgress
