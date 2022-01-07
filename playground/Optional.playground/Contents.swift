import UIKit

// Optional : 값이 있을 수도 있고 없을 수도 있다.
var name:String = "범숭이"
var name2:String = "" // 값이 없진 않음 빈 문자열을 값으로 갖고있음
var number:Int = 0 // 0이라는 값을 갖고있음

var name3: String? = nil // nil 은 값이 없음을 뜻함

// nil은 언제나 쓸 수 있는것은 아님
// 값이 있을 수도 있고 없을 수도 있는 변수의 type 뒤에 물음표를 붙이고 nil을 넣어야함
var number2: Int? = nil
var name4: String? = "밤숑"

// var name5: String = name4 // required 변수에 Optional 변수를 대입할 수 없음 컴파일러는 실행하기 전에 Optional에 데이터가 있는지 없는지 모르기 때문


// Optional Binding
// print(name4) // impilcit하지 않음
// Optional 해제 방법은 2가지 있음
// 1. 명시적 해제 : 강제 해제, 비강제 해제(Optional Binding)
var optionalNum: Int? = nil
//print(optionalNum)
//print(optionalNum!) // ! 강제해제 : 하지만 값이 없고 nil일 경우 에러가 발생함! 주의

if let result = optionalNum {
    print(result)
} else {
    print("optionalNum is nil!")
}

func test() {
    let num: Int? = 5
    guard let result = num else { return } // guard 문은 조건문이 참일때 만 실행한다 아니면 else로 빠짐
    print(result)
}

test()
// 2. 묵시적 해제 : 컴파일러에 의한 자동 해제, 옵셔널의 묵시적 해제
let value: Int? = nil
if value == 6 { // 조건문에서는 컴파일러가 자동으로 해제시킨다. 하지만 다시 감싸지는듯
    print("value가 6 입니다.")
}
else {
    print("value가 6 이 아닙니다.")
}


let string = "ab"
//let string = "asdf"
var stringToInt: Int? = Int(string) // 문자열에 숫자가 아닌 다른것이 들어있으면 nil return
var stringToInt2: Int! = Int(string) // 묵시적 옵셔널 해제! nil은 해제 못함

//print(stringToInt+1)
print(stringToInt2+1)// 묵시적 해제에 의한 자유로운 사용가능!
