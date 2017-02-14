module D3.Geo.Path exposing (..)

import GeoJson
    exposing
        ( GeoJsonObject(..)
        , Geometry(..)
        , FeatureObject
        , Position
        )
import D3.Geo.Stream exposing (newStream, stream)
import D3.Geo.Path.PathString as PathString
import D3.Geo.Types exposing (..)


path : FinalTransformStream -> GeoJsonObject -> String
path transform geoJson =
    stream transform newStream geoJson
        |> PathString.result
