module D3.Geo.Projection exposing (..)

import GeoJson
    exposing
        ( GeoJsonObject(..)
        , Geometry(..)
        , FeatureObject
        , Position
        )
import D3.Geo.Types exposing (..)
import D3.Geo.Transform exposing (transformPoint)
import D3.Geo.Path.PathString as PathString
import D3.Geo.Math as Math exposing (degrees, radians)


--transformRadians : a


transformRadians : FinalTransformStream
transformRadians =
    transformPoint (\( x, y, void ) -> ( x * Math.radians, y * Math.radians, void ))


mutatorProjection : ProjectionMutator -> ( Float, Float ) -> ( Float, Float )
mutatorProjection { k, dx, dy } ( x, y ) =
    let
        point =
            projectRotate (x * Math.radians) (y * Math.radians)
    in
        ( x * k + dx, dy - y * k )



-- recenter : ProjectionMutator


initialProjectionMutator : ProjectionMutator
initialProjectionMutator =
    ProjectionMutator
        -- scale
        150
        -- translate
        480
        250
        -- center
        0
        0
        0
        0
        -- rotate
        0
        0
        0
        0
        0
        -- clip angle
        0
        0
        -- clip extend
        0
        0
        0
        0
        0
        -- precision
        0
        0
        0
        0
