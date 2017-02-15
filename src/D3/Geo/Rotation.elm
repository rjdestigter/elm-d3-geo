module D3.Geo.Rotation exposing (..)

import D3.Geo.Types exposing (..)
import D3.Geo.Math as Math exposing (tau, (%%))
import D3.Geo.Compose exposing (compose)


rad : Float -> Float
rad n =
    n * Math.radians


deg : Float -> Float
deg n =
    n * Math.degrees


rotate : ( Float, Float, Float ) -> Composable
rotate ( rotateX, rotateY, rotateZ ) =
    let
        rotate_ : Composable
        rotate_ =
            rotateRadians
                (rad rotateX)
                (rad rotateY)
                (rad rotateZ)

        forward =
            \( x, y ) ->
                let
                    ( cx, cy ) =
                        rotate_.apply ( rad x, rad y )
                in
                    ( deg cx, deg cy )

        forwardInvert =
            \( x, y ) ->
                let
                    ( cx, cy ) =
                        case rotate_.invert of
                            Just invert ->
                                invert ( rad x, rad y )

                            Nothing ->
                                ( 0, 0 )
                in
                    ( deg cx, deg cy )
    in
        Composable forward (Just forwardInvert)


rotationIdentity_ : ( Float, Float ) -> ( Float, Float )
rotationIdentity_ ( lambda, phi ) =
    if lambda > pi then
        ( lambda - tau, phi )
    else if lambda < -pi then
        ( lambda + tau, phi )
    else
        ( lambda, phi )


rotationIdentity : Composable
rotationIdentity =
    Composable rotationIdentity_ (Just rotationIdentity_)


rotateRadians : Float -> Float -> Float -> Composable
rotateRadians deltaLambda deltaPhi deltaGamma =
    let
        deltaLambda_mod_tau =
            deltaLambda %% tau

        f =
            Debug.log "deltaLambda_mod_tau" deltaLambda_mod_tau
    in
        if deltaLambda_mod_tau > 0 then
            if (deltaPhi > 0 || deltaGamma > 0) then
                compose (rotationLambda deltaLambda_mod_tau) (rotationPhiGamma deltaPhi deltaGamma)
            else
                rotationLambda deltaLambda_mod_tau
        else if (deltaPhi > 0 || deltaGamma > 0) then
            rotationPhiGamma deltaPhi deltaGamma
        else
            rotationIdentity


forwardRotationLambda : Float -> ( Float, Float ) -> ( Float, Float )
forwardRotationLambda deltaLambda ( lambda, phi ) =
    let
        lambdaSum =
            lambda + deltaLambda
    in
        if lambdaSum > pi then
            ( lambdaSum - tau, phi )
        else if lambdaSum < -pi then
            ( lambdaSum + tau, phi )
        else
            ( lambdaSum, phi )


rotationLambda : Float -> Composable
rotationLambda deltaLambda =
    Composable (forwardRotationLambda deltaLambda) (Just (forwardRotationLambda -deltaLambda))


rotationPhiGamma : Float -> Float -> Composable
rotationPhiGamma deltaPhi deltaGamma =
    let
        cosDeltaPhi =
            cos deltaPhi

        sinDeltaPhi =
            sin deltaPhi

        cosDeltaGamma =
            cos deltaGamma

        sinDeltaGamma =
            sin deltaGamma

        rotation =
            \( lambda, phi ) ->
                let
                    cosPhi =
                        cos phi

                    x =
                        (cos lambda) * cosPhi

                    y =
                        (sin lambda) * cosPhi

                    z =
                        sin phi

                    k =
                        z * cosDeltaPhi + x * sinDeltaPhi
                in
                    ( atan2 (y * cosDeltaGamma - k * sinDeltaGamma) (x * cosDeltaPhi - z * sinDeltaPhi)
                    , asin (k * cosDeltaGamma + y * sinDeltaGamma)
                    )

        rotationInvert =
            \( lambda, phi ) ->
                let
                    cosPhi =
                        cos phi

                    x =
                        (cos lambda) * cosPhi

                    y =
                        (sin lambda) * cosPhi

                    z =
                        (sin phi)

                    k =
                        z * cosDeltaGamma - y * sinDeltaGamma
                in
                    ( atan2 (y * cosDeltaGamma + z * sinDeltaGamma) (x * cosDeltaPhi + k * sinDeltaPhi)
                    , asin (k * cosDeltaPhi - x * sinDeltaPhi)
                    )
    in
        Composable rotation (Just rotationInvert)
