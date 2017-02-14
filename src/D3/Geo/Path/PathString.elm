module D3.Geo.Path.PathString exposing (..)

import GeoJson exposing (Position)
import D3.Geo.Types exposing (Radius, Stream)


pathString : List String
pathString =
    []


pointRadius : Radius -> String
pointRadius radius =
    circle radius


defaultPointRadius : String
defaultPointRadius =
    circle 4.5


point : Stream -> Position -> Stream
point stream ( x, y, void ) =
    case stream.point of
        Just 0 ->
            { stream
                | point = Just 1
                , string =
                    List.append stream.string
                        [ "M", toString x, ",", toString y ]
            }

        Just 1 ->
            { stream
                | string =
                    List.append stream.string
                        [ "L", toString x, ",", toString y ]
            }

        _ ->
            { stream
                | string =
                    List.append stream.string
                        [ "M", toString x, ",", toString y, stream.circle ]
            }


result : Stream -> String
result stream =
    String.join "" stream.string


circle : Radius -> String
circle radius =
    let
        strRadius =
            toString radius
    in
        "m0,"
            ++ strRadius
            ++ "a"
            ++ strRadius
            ++ ","
            ++ strRadius
            ++ " 0 1,1 0,"
            ++ (-2 * radius |> toString)
            ++ "a"
            ++ strRadius
            ++ ","
            ++ strRadius
            ++ " 0 1,1 0,"
            ++ (2 * radius |> toString)
            ++ "z"
