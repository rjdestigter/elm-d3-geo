module D3.Geo.Types exposing (..)

import GeoJson
    exposing
        ( GeoJsonObject(..)
        , Geometry(..)
        , FeatureObject
        , Position
        )


type alias Radius =
    Float



-- Stream Types


type alias Stream =
    { circle : String
    , string : List String
    , point : Maybe Int
    , line : Int
    }



-- Transform Types


type alias PointStreamer =
    Position -> Position


type alias TransformStream =
    { point : Maybe PointStreamer
    }


type alias FinalTransformStream =
    { point : Stream -> Position -> Stream
    , point_ : Stream -> Position -> Stream
    }



-- Projection


type alias Composable =
    { apply : ( Float, Float ) -> ( Float, Float )
    , invert : Maybe (( Float, Float ) -> ( Float, Float ))
    }


type alias ProjectionMutator =
    -- scale
    { k :
        Float
        -- // translate
    , x : Float
    , y :
        Float
        -- center
    , dx : Float
    , dy : Float
    , lambda : Float
    , phi :
        Float
        -- rotate
    , deltaLambda : Float
    , deltaPhi : Float
    , deltaGamma : Float
    , rotate : Float
    , projectRotate :
        Float
        -- clip angle
    , theta : Float
    , preclip :
        Float
        -- clip extend
    , x0 : Float
    , y0 : Float
    , x1 : Float
    , y1 : Float
    , postclip :
        Float
        -- precision
    , delta2 : Float
    , projectResample : Float
    , cache : Float
    , cacheStream : Float
    }
