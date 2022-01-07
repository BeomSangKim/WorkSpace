import UIKit

// Extension
// 기존 클래스, 구조체, 열거형, 프로토콜에 새로운 기능을 추가하는 기능

// extension이 타입에 추가할 수 있는 기능
// 1. 연산 타입 프로퍼티/ 연산 인스턴스 프로퍼티 // 저장프로퍼티 감시자 프로퍼티는 안댐!
// 2. 타입 메서드/ 인스턴스 메서드
// 3. 이니셜라이져
// 4. 서브스크립트
// 5. 중첩타입
// 6. 특정 프로토콜울 준수할 수 있도록 기능 추가
// 기존기능을 override하진 못한다.

/*
 extension SomeType {
    // 추가 기능
 }
 */

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    var isOdd: Bool {
        return self % 2 == 1
    }
}


var num = 10

num.isOdd
num.isEven

extension String {
    func convertToInt() -> Int? {
        return Int(self)
    }
}

var s = "10"

s.convertToInt()

