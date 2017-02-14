module D3.Geo.Projection.Mercator exposing (..)

import D3.Geo.Math exposing (log, halfPi)


mercatorRaw : Float -> Float -> List Float
mercatorRaw lambda phi =
    [ lambda, log (tan ((halfPi + phi) / 2)) ]
