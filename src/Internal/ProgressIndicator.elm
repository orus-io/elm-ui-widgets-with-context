module Internal.ProgressIndicator exposing (ProgressIndicatorStyle, circularProgressIndicator)

import Internal.Context exposing (Element)


{-| -}
type alias ProgressIndicatorStyle context msg =
    { elementFunction : Maybe Float -> Element context msg
    }


circularProgressIndicator :
    ProgressIndicatorStyle context msg
    -> Maybe Float
    -> Element context msg
circularProgressIndicator style maybeProgress =
    style.elementFunction maybeProgress
