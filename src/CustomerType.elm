module CustomerType exposing (CustomerType)

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
