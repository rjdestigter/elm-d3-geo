module D3.Geo.Stream exposing (..)

import GeoJson
    exposing
        ( GeoJsonObject(..)
        , Geometry(..)
        , FeatureObject
        , Position
        )
import D3.Geo.Types exposing (..)
import D3.Geo.Path.PathString as PathString


newStream : Stream
newStream =
    Stream PathString.defaultPointRadius [] Nothing 0


streamFeature : FinalTransformStream -> Stream -> FeatureObject -> Stream
streamFeature transform stream feature =
    case feature.geometry of
        Just geometry ->
            streamGeometry transform stream geometry

        Nothing ->
            stream


streamFeatureCollection : FinalTransformStream -> Stream -> List FeatureObject -> Stream
streamFeatureCollection transform stream featureCollection =
    stream


streamGeometry : FinalTransformStream -> Stream -> Geometry -> Stream
streamGeometry transform stream geometry =
    case geometry of
        Point position ->
            transform.point stream position

        _ ->
            stream


streamPoint : Stream -> Position -> Stream
streamPoint stream point =
    stream


foldlPoint : Position -> Stream -> Stream
foldlPoint point stream =
    streamPoint stream point


streamMultiPoint : Stream -> List Position -> Stream
streamMultiPoint stream points =
    List.foldl foldlPoint stream points


stream : FinalTransformStream -> Stream -> GeoJsonObject -> Stream
stream transform stream geoJson =
    case geoJson of
        Geometry geometry ->
            streamGeometry transform stream geometry

        Feature feature ->
            streamFeature transform stream feature

        FeatureCollection featureCollection ->
            streamFeatureCollection transform stream featureCollection
