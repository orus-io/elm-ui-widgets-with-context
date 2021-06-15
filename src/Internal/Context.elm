module Internal.Context exposing (Attr, Attribute, Context, Element, Label, Placeholder)

import Element.WithContext as Element
import Element.WithContext.Input as Input


type alias Context context theme =
    { context
        | theme : theme
        , device : Element.Device
    }


type alias Attribute context theme msg =
    Element.Attribute (Context context theme) msg


type alias Attr decorative context theme msg =
    Element.Attr decorative (Context context theme) msg


type alias Element context theme msg =
    Element.Element (Context context theme) msg


type alias Placeholder context theme msg =
    Input.Placeholder (Context context theme) msg


type alias Label context theme msg =
    Input.Label (Context context theme) msg
