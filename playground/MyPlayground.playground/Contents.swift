import Foundation

// 상수
// let 상수명 : 데이터 타입 = 값
let a: Int = 100
let a2 = 100
// 변수
// var 변수명: 데이터 타입 = 값
var b: Int = 200
var b2 = 200

var c: Float = 10.0
var c1 = 10.0

var d: Character = "A"
var d1 = "A"


// data type
// Int 64bit 정수형
var someInt: Int = -100
someInt = 100

// UInt : 부호가 없는 64bit 정수형
var someUInt: UInt = 200

// Float : 32bit 부동소수점
var someFloat: Float = 1.1
someFloat = 1
print(someFloat)

// Double : 64bit 부동소수점
var someDouble: Double = 1.1
someDouble = 1

// Bool : true, false 값
var someBool: Bool = true
someBool = false

// Character : 문자
var someCharacter: Character = "가"
someCharacter = "A"
someCharacter = "😇"
someCharacter = "a"

// String : 문자열
var someString: String = "안녕하세요 😍"


// type inference
var num = 10

// 컬렉션 타입
// Array : 데이터 타입의 값들을 순서대로 저장하는 리스트
var numbers: Array<Int> = Array<Int>()
numbers
numbers.append(1)
numbers.append(3)
numbers.append(2)
numbers.append(5)

numbers[0]
numbers[1]

numbers.insert(4, at: 2)
numbers.remove(at: 0)
numbers

var names = [Int]()
var names2: [Int] = []


// Dictionary : 순서없이 키(key)와 값(Value) 한 쌍으로 데이터를 저장하는 컬렉션 타입
var dic: Dictionary<String, Int> = Dictionary<String, Int>()


var dic2: [String: Int] = ["아로미": 100]
dic2["범순"] = 50
dic2.keys

dic2["범순"] = 49
dic2["아로미"]
dic2
dic2.removeValue(forKey: "범순")
dic2

// Set : 같은 테이터 타입의 값을 순서없이 저장하는 리스트
// 중복된 값은 허용되지 않음, 축약형 선언이 불가능 // 내부적으로 hash가능 하도록 구현되서 그런듯?

var set: Set = Set<Int>()
set.insert(10)
set.insert(20)
set.insert(15)
set.insert(15)
set.insert(15)
set

set.remove(20)
set

var set2: Set = Set<Dictionary<String, Int>>()
set2.insert(dic2)
set2.insert(["범숭":200])

set2

// func 함수명(파라미터이름: 데이터 타입)->반환 타입 {
//     return 반환값
// }

func sum(a: Int, b: Int) -> Int {
    return a+b
}

var ret: Int = sum(a: 5, b: 3)
ret

func hello() -> String {
    return "hello"
}

hello()

// 반환값이 없는 함수
func printname() -> Void {
    
}

func printname2() {
    
}

func sendMessage(friend: String, me: String = "밤숭이") {
    print("Helle, \(friend)! I'm \(me)")
}

sendMessage(friend: "아로미😝")

// from to = 전달인자 레이블 그냥 별명같은걸로 쓰이는듯
func sendMessage(from myName: String, to name : String)-> String {
    return "Hello \(name)!, I'm \(myName)"
}

sendMessage(from: "밤숭이🥲", to: "아로미😝")

// 전달인자 레이블을 사용하지 않는 함수
func sendMessage(_ myName: String, _ name: String)-> String {
    return "Hello \(name)!, I'm \(myName)"
}

sendMessage("밤숭숭숭", "아롬롬롬")

// 가변 매개변수 0개 이상의 매개변수를 받아올 수 있음!
// 가변 매개변수로 들어온 값은 배열처럼 사용이 가능!
// friends가 가변 매개변수로 사용됨
func sendMessage(_ myName: String, _ friends: String ...)-> String {
    return "Hello \(friends)!, I'm \(myName)"
}

sendMessage("밤숭이", "아로미!", "서준이", "용락이")
// swift는 다중 페러다임 언어이다.

// 조건문
// if, switch, guard

/* if 조건식 {
  // 실행할 구문
 }
*/
let age = 19

if age < 19 {
    print("미성년자 입니다.")
}

/* if 조건식 {
  // 실행할 구문
 } else {
  // 실행할 구문
 }
*/

if age < 19 {
 // 실행할 구문
    print("미성년자")
} else {
 // 실행할 구문
    print("성년자")
}

/* if 조건식 {
  // 실행할 구문
 } else if 조건식 2{
  // 실행할 구문
 } else {
 // 실행할 구문
}
*/
let animal = "밤숭이"

if animal == "dog" {
    print("강하지 사료주기")
} else if animal == "cat" {
    print("고양이 사료주기")
} else {
    print("\(animal) 사료주기")
}

/*
switch 비교대상 {
    case 패턴1:
        // 패턴1 일치할때 실행되는 구문
    case 패턴2, 패턴3:
        // 패턴2,3이 일치할 때 실행되는 구문
    default:
        // 어느 비교 패턴과도 일치 하지 않을때 실행되는 구문
 }
*/

let color = "yello"

switch color {
case "blue":
    print("파란색입니다.")
case "green":
    print("초록색입니다.")
default:
    print("\(color)색입니다.")
}

let food = "pepsi"

switch food {
case "sprite":
    print("사이다 입니다.")
case "coca", "pepsi":
    print("콜라 입니다.")
default:
    print("\(food) 입니다.")
}

let level = 10

switch level {
case 0...9:
    print("쪼렙 입니다!")
case 10...14:
    print("중수 입니다.")
default:
    print("쫌 잘하시는군요!")
}


let temporature = 10

switch temporature {
case -10...9:
    print("겨울 입니다.")
case 10...14:
    print("가을 입니다.")
case ..<19:
    print("여름")
default:
    print("이상기후입니다.")
}

var test = (1...10 ~= 5)

var test1 = (...10 ~= -5)
var test2 = (10... ~= -5)
var test3 = (..<10 ~= -5)


// 반복문
// for-in, while, repeat-while

/*
 for 루프상수 in 순회대상 { // 루프상수 = 구문이 반복될 때마다 순회대상에 포함하는아이템을 넘겨받음 // 순회대상 Set, Array, Dictionary, var
  // 실행할 구문...
 }
 */

for i in 0...10 {
    print(i)
}

let array = [1,2,5,4,5]

for i in array {
    print(i)
}

var numberArray: Array<Int> = Array<Int>()

for i in array {
    numberArray.append(i)
}
numberArray




/*
 while 조건식 {
  // 실행할 구문
 }
 */

var numwhile = 5

while numwhile < 5 {
    numwhile+=10
    numwhile
}


/*
 repeat {       // 한번은 반드시 실행되는 반복문
  // 실행할 구문
 } while 조건식
 */

var numrepeatwhile = 6
repeat {
    numrepeatwhile+=2
} while numrepeatwhile < 5

print(numrepeatwhile)
