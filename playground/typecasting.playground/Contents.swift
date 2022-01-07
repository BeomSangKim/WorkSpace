import UIKit

// typecasting이란?
// Instance의 타입을 확인하거나 어떠한 클래스의 인스턴스를 해당 클래스 계층 구조의 슈퍼클래스나 서브 클래스로 취급하는 방법이다.

// is, as 연산자

class Shop {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Cafe: Shop {
    var kindOfCoffee: Int
    init(name: String, kindOfCoffee: Int){
        self.kindOfCoffee = kindOfCoffee
        super.init(name: name)
    }
}

class Restaurant: Shop {
    var kindOfMenu: Int
    init(name: String, kindOfMenu: Int){
        self.kindOfMenu = kindOfMenu
        super.init(name: name)
    }
}

var numberOfRestaurant = 0
var numberOfCafe = 0

let library = [
    Cafe(name: "⭐️다방", kindOfCoffee: 20),
    Restaurant(name: "중국반점", kindOfMenu: 10),
    Cafe(name: "2Some", kindOfCoffee: 25)
]

//
for item in library {
    if item is Cafe{
        numberOfCafe += 1
    }
    else if item is Restaurant {
        numberOfRestaurant += 1
    }
}

print("Shop library contains \(numberOfRestaurant) Restaurants and \(numberOfCafe) cafes.")

// as? or as!
// as? 조건부 반환 downcasting 가능할때만 반환
// as! 강제 unwrapping 후 반환 ! downcasting이 확실히 가능할때만
for item in library {
    if let cafe = item as? Cafe {
        print("Cafe: \(cafe.name), kind of coffee: \(cafe.kindOfCoffee)")
    }
    else if let restaurant = item as? Restaurant {
        print("Restaurant: \(restaurant.name), kind of menu: \(restaurant.kindOfMenu)")
    }
}
