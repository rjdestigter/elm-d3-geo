module D3.Geo.Math exposing (..)


epsilon : Float
epsilon =
    1.0e-6


epsilon2 : Float
epsilon2 =
    1.0e-12


halfPi : Float
halfPi =
    pi / 2


quarterPi : Float
quarterPi =
    pi / 4


log : Float -> Float
log =
    logBase e


tau : Float
tau =
    pi * 2


degrees : Float
degrees =
    180 / pi


radians : Float
radians =
    pi / 180


sign : Float -> Float
sign x =
    if x > 0 then
        1
    else if x < 0 then
        -1
    else
        0


acos : Float -> Float
acos x =
    if x > 1 then
        0
    else if (x < -1) then
        pi
    else
        Basics.acos x


asin : Float -> Float
asin x =
    if x > 1 then
        halfPi
    else if x < -1 then
        -halfPi
    else
        Basics.asin x


haversin : Float -> Float
haversin x =
    let
        y =
            sin (x / 2)
    in
        y * y


(%%) : Float -> Float -> Float
(%%) a b =
    let
        divided =
            a / b

        rest =
            divided - (floor divided |> toFloat)
    in
        rest * b
