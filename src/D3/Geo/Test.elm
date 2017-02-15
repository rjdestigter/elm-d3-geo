module D3.Geo.Test exposing (..)

import Json.Encode as Encode
import GeoJson
    exposing
        ( GeoJsonObject(..)
        , Geometry(..)
        , FeatureObject
        , Position
        )
import D3.Geo.Path exposing (path)
import D3.Geo.Transform exposing (default)
import D3.Geo.Rotation as Rotation exposing (..)
import Html exposing (text)


samplePoint : GeoJsonObject
samplePoint =
    ( 125.6, 10.1, 125.6 )
        |> Point
        |> Just
        |> (\point -> FeatureObject point Encode.null Nothing)
        |> Feature


main =
    let
        x =
            Debug.log "start" (path default samplePoint)

        r =
            rotateRadians 100 20 3
    in
        case
            r.invert
        of
            Just invert ->
                text (toString (r.apply ( 39, 50 )))

            Nothing ->
                text (toString (r.apply ( 39, 50 )))
