module Ticket exposing (Discount, Ticket)

import DayType exposing (DayType)



-- 最初は年齢から学生区分などを判断する関数を作ろうとしたが
-- 浪人生や留年生、放送大学生は年齢によらず学生の可能性があるのでやめた
-- もう自己申告してもらうしかない


type CustomerType
    = CinemaCitizen
    | SeniorCinemaCitizen -- シネマシティズン(60~)
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
    = Unspecified
    | MICard -- MIカードは他割引との不可
    | Parking



-- 料金一覧を見ると1000円というのが全体のレギュラープライスに見えるので
-- レギュラーとそれ以外に分けることとした


type Ticket
    = Regular -- 1000円
    | Invalid -- 適用不可
    | Special Int



-- TODO:
-- - もし75歳の大学生がいた場合にはどちらの価格が適用されるんだ？
-- - 障害者カスタマの同伴者の割引判断


new : DayType -> CustomerType -> Discount -> Ticket
new dayType customerType discount =
    case discount of
        MICard ->
            dayType
                |> DayType.ensureAll
                    { weekday = always (Special 1600)
                    , weekdayLate = always (Special 1300)
                    , weekendOrHoliday = always (Special 1600)
                    , weekendOrHolidayLate = always (Special 1300)
                    , cinemaDay = always Invalid
                    }

        Parking ->
            dayType
                |> DayType.ensureAll
                    { weekday = always (Special 1400)
                    , weekdayLate = always (Special 1100)
                    , weekendOrHoliday = always (Special 1400)
                    , weekendOrHolidayLate = always (Special 1100)
                    , cinemaDay = always Invalid
                    }

        Unspecified ->
            case customerType of
                CinemaCitizen ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always Regular
                            , weekdayLate = always Regular
                            , weekendOrHoliday = always (Special 1300)
                            , weekendOrHolidayLate = always Regular
                            , cinemaDay = always (Special 1100)
                            }

                SeniorCinemaCitizen ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always Regular
                            , weekdayLate = always Regular
                            , weekendOrHoliday = always Regular
                            , weekendOrHolidayLate = always Regular
                            , cinemaDay = always Regular
                            }

                Adult ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always (Special 1800)
                            , weekdayLate = always (Special 1300)
                            , weekendOrHoliday = always (Special 1800)
                            , weekendOrHolidayLate = always (Special 1300)
                            , cinemaDay = always (Special 1100)
                            }

                Senior ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always (Special 1100)
                            , weekdayLate = always (Special 1100)
                            , weekendOrHoliday = always (Special 1100)
                            , weekendOrHolidayLate = always (Special 1100)
                            , cinemaDay = always (Special 1100)
                            }

                CollegeStudent ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always (Special 1500)
                            , weekdayLate = always (Special 1300)
                            , weekendOrHoliday = always (Special 1500)
                            , weekendOrHolidayLate = always (Special 1300)
                            , cinemaDay = always (Special 1100)
                            }

                Student ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always Regular
                            , weekdayLate = always Regular
                            , weekendOrHoliday = always Regular
                            , weekendOrHolidayLate = always Regular
                            , cinemaDay = always Regular
                            }

                Child ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always Regular
                            , weekdayLate = always Regular
                            , weekendOrHoliday = always Regular
                            , weekendOrHolidayLate = always Regular
                            , cinemaDay = always Regular
                            }

                AdultWithDisability ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always Regular
                            , weekdayLate = always Regular
                            , weekendOrHoliday = always Regular
                            , weekendOrHolidayLate = always Regular
                            , cinemaDay = always Regular
                            }

                StudentWithDisability ->
                    dayType
                        |> DayType.ensureAll
                            { weekday = always (Special 900)
                            , weekdayLate = always (Special 900)
                            , weekendOrHoliday = always (Special 900)
                            , weekendOrHolidayLate = always (Special 900)
                            , cinemaDay = always (Special 900)
                            }


toYen : Ticket -> Maybe Int
toYen ticket =
    case ticket of
        Regular ->
            Just 1000

        Special value ->
            Just value

        Invalid ->
            Nothing
