module DayType exposing (DayType(..), fromTime)

import Time


type DayType
    = Weekday
    | WeekdayLate
    | WeekendOrHoliday
    | WeekendOrHolidayLate
    | CinemaDay


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
