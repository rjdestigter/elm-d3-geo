module D3.Geo.Transform exposing (..)

import GeoJson
    exposing
        ( GeoJsonObject(..)
        , Geometry(..)
        , FeatureObject
        , Position
        )
import D3.Geo.Path.PathString as PathString
import D3.Geo.Types exposing (..)


transform : TransformStream -> FinalTransformStream
transform transformStream =
    FinalTransformStream
        (point transformStream.point)
        (point Nothing)


default : FinalTransformStream
default =
    transform
        { point = Nothing
        }


transformPoint : PointStreamer -> FinalTransformStream
transformPoint pointStreamer =
    pointStreamer
        |> Just
        |> TransformStream
        |> transform


point : Maybe PointStreamer -> Stream -> Position -> Stream
point pointStreamer stream position =
    case pointStreamer of
        Just streamer ->
            position
                |> streamer
                |> PathString.point stream

        Nothing ->
            PathString.point stream position
