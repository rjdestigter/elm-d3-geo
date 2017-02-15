module D3.Geo.Compose exposing (compose)

import D3.Geo.Types exposing (..)


compose : Composable -> Composable -> Composable
compose a b =
    let
        invert =
            case ( a.invert, b.invert ) of
                ( Just invertA, Just invertB ) ->
                    Just (\tuple -> invertA (invertB tuple))

                _ ->
                    Nothing
    in
        Composable
            (\tuple ->
                let
                    k =
                        Debug.log "tuple" tuple

                    l =
                        Debug.log "a.apply" (a.apply tuple)
                in
                    b.apply (a.apply tuple)
            )
            invert
