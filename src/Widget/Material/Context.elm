module Widget.Material.Context exposing (..)

import Element.WithContext as Element
import Internal.Context exposing (Context)
import Internal.Material.Palette exposing (Palette)


type alias Context context =
    { context
        | device : Element.Device
        , material : Palette
    }


withPalette fun =
    Element.with (\{ material } -> fun material)


withPaletteDecoration fun =
    Element.withDecoration (\{ material } -> fun material)


withPaletteAttribute fun =
    Element.withAttribute (\{ material } -> fun material)


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


getPalette : Context context -> Palette
getPalette =
    .material


getBackground =
    getPalette >> .background


getPrimaryColor =
    getPalette >> .primary


getSurfaceColor =
    getPalette >> .surface
