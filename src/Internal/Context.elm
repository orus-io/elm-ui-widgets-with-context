module Internal.Context exposing (Attr, Attribute, Context, Element, Label, Placeholder)

import Element.WithContext as Element
import Element.WithContext.Input as Input


type alias Context context =
    { context
        | device : Element.Device
    }


type alias Attribute context msg =
    Element.Attribute (Context context) msg


type alias Attr decorative context msg =
    Element.Attr decorative (Context context) msg


type alias Element context msg =
    Element.Element (Context context) msg


type alias Placeholder context msg =
    Input.Placeholder (Context context) msg


type alias Label context msg =
    Input.Label (Context context) msg
