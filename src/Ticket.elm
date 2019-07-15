module Ticket exposing (Discount, Ticket)

import DayType exposing (DayType)
import Price exposing (Price)



-- 最初は年齢から学生区分などを判断する関数を作ろうとしたが
-- 浪人生や留年生、放送大学生は年齢によらず学生の可能性があるのでやめた
-- もう自己申告してもらうしかない


type CustomerType
    = CinemaCitizen
    | Adult -- 一般
    | Senior -- シニア
    | CollegeStudent -- 大学生
    | Student
    | Child
    | AdultWithDisability
    | StudentWithDisability



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
