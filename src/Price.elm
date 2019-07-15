module Price exposing (Price, regular, toInt)

-- 料金一覧を見ると1000円というのが全体のレギュラープライスに見えるので
-- レギュラーとそれ以外に分けることとした


type Price
    = Regular -- 1000円
    | Other Int


regular : Price
regular =
    Regular


toInt : Price -> Int
toInt price =
    case price of
        Regular ->
            1000

        Other value ->
            value
