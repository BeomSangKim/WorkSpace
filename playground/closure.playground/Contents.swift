import UIKit
import Foundation

// 클로저
// 참조 타입!!이며 코드에서 전달 및 사용할 수 있는 독립 기능 블록이다.
// 일급 객체의 역할을 할 수 있다.

// 일급객체
// 전달 인자로 보낼 수 있고, 변수/상수 등으로 저장하거나 전달할 수 있으며, 함수의 반환 값이 될 수도 있다.

// 클로져는 보통 이름없는 함수 익명함수를 지칭
// 람다함수와 비슷한듯

/*
 { (매개변수) -> returnType in
    // 실행구문
 }
 */

let hello = { () -> () in
    print("hello world!!")
}

hello()

let hello2 = { (name: String) -> String in
    return "Hello, \(name)!"
}

// 전달함수 레이블 사용불가능
// hello2(name: "아로로밍")
print(hello2("아로롱미"))

func doSomething(closure: ()-> ()){
    closure()
}

doSomething(closure: {()->() in print("hello")})

func doSomething2()-> ()->() {
    return {() -> () in
        print("hello~~~")
    }
}

doSomething2()()

// 후앤클로져 맨마지막 인자로만 사용가능

doSomething() {
    print("hello2")
}

doSomething() {
    print("hello3")
}

func doSomething2(success: () -> (), fail: () -> ()){
    success()
    fail()
    print("asdf")
}

doSomething2 {
    print("qwer")
} fail: {
    print("zxv")
}


doSomething2(success: {()->() in }, fail: {()->() in})

func doSomething3(closure: (Int, Int, Int) -> Int){
    closure(1,2,3)
}

doSomething3(closure: {(alpha, beta, gamma) in
    return alpha+beta+gamma
})

doSomething3(closure: {
    return $0 * $1 * $2 * $2
})


doSomething3(closure: {
    // return 생략시에는 한줄만 가능 return 추론이 힘들기 때문
    $0 * $1 * $1 * $2
})

doSomething3() {
    $0 + $0 * $1 * $2
}

doSomething3 {
    $0 * $1 + $1 * $2
}
