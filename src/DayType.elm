module DayType exposing (DayType(..), ensureAll, fromTime)

import Time


type DayType
    = Weekday
    | WeekdayLate
    | WeekendOrHoliday
    | WeekendOrHolidayLate
    | CinemaDay


type alias Payload a =
    { weekday : DayType -> a
    , weekdayLate : DayType -> a
    , weekendOrHoliday : DayType -> a
    , weekendOrHolidayLate : DayType -> a
    , cinemaDay : DayType -> a
    }


ensureAll : Payload a -> DayType -> a
ensureAll { weekday, weekdayLate, weekendOrHoliday, weekendOrHolidayLate, cinemaDay } dayType =
    case dayType of
        Weekday ->
            weekday dayType

        WeekdayLate ->
            weekdayLate dayType

        WeekendOrHoliday ->
            weekendOrHoliday dayType

        WeekendOrHolidayLate ->
            weekendOrHolidayLate dayType

        CinemaDay ->
            cinemaDay dayType


fromTime : Time.Posix -> DayType
fromTime time =
    let
        weekday =
            Time.toWeekday Time.utc time

        isLate =
            Time.toHour Time.utc time > 20
    in
    if Time.toDay Time.utc time == 1 then
        CinemaDay

    else
        case weekday of
            Time.Sat ->
                if isLate then
                    WeekendOrHolidayLate

                else
                    WeekendOrHoliday

            Time.Sun ->
                if isLate then
                    WeekendOrHolidayLate

                else
                    WeekendOrHoliday

            _ ->
                -- TODO: 祝日かどうかを判断するロジックをここにいれる
                Weekday
