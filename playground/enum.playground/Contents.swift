import Foundation

// enum : 연관성이 있는 값을 모아 놓은 것을 말한다.

// 각 항목은 항목자체가 고유값
enum Season {
    case spring
    case summer
    case fall
    case winter
    // case spring, summer, fall, winter
}

var mySeason: Season = Season.fall
mySeason = .summer


switch mySeason {
case .fall:
    print("fall")
case .summer:
    print("summer")
case .spring:
    print("spring")
case .winter:
    print("winter")
}


enum StringSeason: String {
    case spring = "봄"
    case summer = "여름"
    case fall = "가을"
    case winter = "겨울"
}

var myStringSeason: StringSeason = StringSeason.fall
myStringSeason = .summer


switch myStringSeason {
case .fall:
    print(myStringSeason.rawValue)
case .summer:
    print(myStringSeason.rawValue)
case .spring:
    print(myStringSeason.rawValue)
case .winter:
    print(myStringSeason.rawValue
    )
}

let myStringSeason2 = StringSeason(rawValue: "여름")

enum KindError {
    case unknownError
    case newError(String)
}

let error = KindError.newError("처음보는에러입니다.")

switch error {
case .newError(let message):
    print(message)
case .unknownError:
    print("몰라용")
}
