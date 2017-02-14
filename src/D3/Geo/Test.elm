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
    in
        text "Hello"
