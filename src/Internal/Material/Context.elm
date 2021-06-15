module Internal.Material.Context exposing (..)

import Element.WithContext as Element
import Internal.Context exposing (Context)
import Internal.Material.Palette exposing (Palette)


type alias Theme =
    Palette


wrap : (Palette -> style) -> Context context Palette -> style
wrap fn { theme } =
    fn theme


withPalette fun =
    Element.with (\{ theme } -> fun theme)


withPaletteDecoration fun =
    Element.withDecoration (\{ theme } -> fun theme)


withPaletteAttribute fun =
    Element.withAttribute (\{ theme } -> fun theme)


withPrimaryDecoration fun =
    withPaletteDecoration (.primary >> fun)


withPrimaryAttribute fun =
    withPaletteAttribute (.primary >> fun)


withOnPrimaryDecoration fun =
    withPaletteDecoration (.on >> .primary >> fun)


withOnPrimaryAttribute fun =
    withPaletteAttribute (.on >> .primary >> fun)


withSurfaceDecoration fun =
    withPaletteDecoration (.surface >> fun)


withSurfaceAttribute fun =
    withPaletteAttribute (.surface >> fun)


withOnSurfaceDecoration fun =
    withPaletteDecoration (.on >> .surface >> fun)


withOnSurfaceAttribute fun =
    withPaletteAttribute (.on >> .surface >> fun)


getPrimaryColor =
    .theme >> .primary


getSurfaceColor =
    .theme >> .surface
