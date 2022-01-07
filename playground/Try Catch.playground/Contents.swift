import UIKit

// Try-Catch
// 프로그램 내에서 에러가 발생한 상황에 대해 대응하고 이를 복구하는 과정

// 에러처리
// 발생 (throwing)
// 감지 (catching)
// 전파 (propagating)
// 조작 (manipulating)

// Error프로토콜을 채택해야함
enum PhoneError : Error {
    case unknown
    case batteryLow(batteryLevel: Int)
}

// throw PhoneError.batteryLow(batteryLevel: 20)

// error 처리 방법 1 : 함수에서 발생한 오류를 해당함수에 전파하는 방법

func checkPhoneBatteryStatus(batteryLevel: Int) throws -> String {
    guard batteryLevel != -1 else { throw PhoneError.unknown }
    guard batteryLevel >= 20 else { throw PhoneError.batteryLow(batteryLevel: batteryLevel)}
    return "배터리 상태가 정상입니다."
        
}

/*
 do {
    try 오류 발생 가능한 코드
 } catch 오류 패턴 {
    처리 코드
 
 }
 */
let curbatteryLevel = 14

do {
    try checkPhoneBatteryStatus(batteryLevel: curbatteryLevel)
} catch PhoneError.unknown {
    print("알 수 없는 에러입니다.")
} catch PhoneError.batteryLow(let batteryLevel) {
    print("남은 배터리 레벨 : \(batteryLevel)%")
} catch {
    print("그 외 오류 발생 : \(error)")
}

let status = try? checkPhoneBatteryStatus(batteryLevel: 20)
print("\(status)") // nil or optional

let status2 = try! checkPhoneBatteryStatus(batteryLevel: -1)
print("\(status2)") // not nil, not optional // if error program terminate!
