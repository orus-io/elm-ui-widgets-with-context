module Widget.Material.Context exposing (..)

import Element.WithContext as Element
import Internal.Context
import Internal.Material.Palette exposing (Palette)


type alias Context context theme =
    Internal.Context.Context context (Theme theme)


type alias Theme theme =
    { theme
        | material : Palette
    }


withTheme fun =
    Element.with (\{ theme } -> fun theme)


withPalette fun =
    withTheme (.material >> fun)


withPaletteDecoration fun =
    Element.withDecoration (\{ theme } -> fun theme.material)


withPaletteAttribute fun =
    Element.withAttribute (\{ theme } -> fun theme.material)


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


withBackground fun =
    withPalette (.background >> fun)


withBackgroundAttribute fun =
    withPaletteAttribute (.background >> fun)


withBackgroundDecoration fun =
    withPaletteDecoration (.background >> fun)


withOnBackground fun =
    withPalette (.on >> .background >> fun)


withOnBackgroundAttribute fun =
    withPaletteAttribute (.on >> .background >> fun)


withOnBackgroundDecoration fun =
    withPaletteDecoration (.on >> .background >> fun)


getBackground =
    .theme >> .material >> .background


getPrimaryColor =
    .theme >> .material >> .primary


getSurfaceColor =
    .theme >> .material >> .surface


getPalette =
    .theme >> .material
