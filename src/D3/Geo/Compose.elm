module D3.Geo.Compose exposing (compose)

import D3.Geo.Types exposing (..)


compose : Composable -> Composable -> Composable
compose a b =
    let
        invert =
            case a.invert of
                Just invertA ->
                    case b.invert of
                        Just invertB ->
                            Just (\tuple -> invertA (invertB tuple))

                        Nothing ->
                            Nothing

                Nothing ->
                    Nothing
    in
        Composable (\tuple -> b.apply (a.apply tuple)) invert
