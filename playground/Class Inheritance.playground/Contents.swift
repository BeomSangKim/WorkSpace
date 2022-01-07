import UIKit

// Base Class : 어떤 클래스의 상속도 받지 않은 클래스
class Car {
    let maxCarGasStorage: Double = 100.0
    var speed: Int = 0
    var navigation: String {
        return "We are moving at \(speed)km/h"
    }
    func horn() {
        print("빵빵😄")
    }
    // final keyword override 불가능!
    final var kind: String = "Car"
}
/*
 class 클래스이름 : 부모클래스 이름 {
    // 하위 클래스 정의
 }
 */
class Sonatte : Car {
    var isSunLoop : Bool = false
    override var navigation: String {
        return "Sonatte is moving at \(speed)km/h!"
    }
    override func horn() {
        // super class 활용
        super.horn()
        print("빠아아앙🤓")
    }
    // final keyword override 불가능!
    // var kind: String
}

var mySona: Sonatte = Sonatte()
mySona.maxCarGasStorage
mySona.speed = 10
mySona.speed
mySona.horn()
print("\(mySona.navigation)")


class Avanta : Car {
    var gearCount :Int = 5
    var brakeLevel: Int = 0
    override var speed: Int{
        didSet{ // let 에서는 사용 불가능
            brakeLevel = Int(speed / 10) + 1
        }
    }
    override var navigation: String {
        return super.navigation + " with \(brakeLevel) brake level"
    }
}

let myAvanta: Avanta = Avanta()
myAvanta.speed = 20
print("\(myAvanta.navigation)")

