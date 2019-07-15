module Ticket exposing (Discount, Ticket)

import CustomerType exposing (CustomerType)
import DayType exposing (DayType)
import Price exposing (Price)



-- Discountは表の中ではカスタマーの区分と同列になっているが
-- 実際には別区分であるようにみえるので分けた


type
    Discount
    -- 夫婦50割はリストには含まれているが終了したためDiscountには含めない
    = Nothing
    | MICard -- MIカードは他割引との不可
    | Parking



-- Ticketを表現するOpeque Type


type Ticket
    = Ticket Price


new : DayType -> CustomerType -> Discount -> Ticket
new dayType customerType discount =
    Ticket Price.regular


toPrice : Ticket -> Price
toPrice (Ticket price) =
    price
