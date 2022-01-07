import UIKit

// 클래스
/*
class 클래스 이름 {
    프로퍼티와 메서드
}
*/
class Dog {
    // 프로퍼티
    // 저장 프로퍼티, 연산 프로퍼티, 타입 프로퍼티
    // 저장 프로퍼티 : 인스턴스의 변수나 상수
    // 연산 프로퍼티 : 특정 연산을 실행하는 결과값
    // 타입 프로퍼티 : 특정 타입을 의미하는 프로퍼티
    
    // 저장 프로퍼티
    var name: String = ""
    var age: Int = 0 {
        // 앞에 func도 안붙는 이상한 함수???
        // 값이 저장되기 전에 호출되는 옵저버 프로퍼티! willSet, didSet이 있다!
        willSet {
            print("\(name)의 나이가 \(age)에서 \(newValue)로 변경될 예정이다!") // 기본매개변수 newValue
        }
        
        didSet {
            print("\(name)의 나이가 \(oldValue)에서 \(age)로 변경되었다!") // 기본매개변수 oldValue
        }
    }
    let sex: String //let 선언시 init에서 반드시 초기화 필요!
    var oldOrYoung: String = ""
    var warning: Int = 0
    // 연산 프로퍼티
    var propertyAge : Int {
        get {
            return age + 1
        }
        
        // default parameter : newValue
        // set(newAge) {
        set {
            // age = newAge
            age = newValue
            if age > 5 {
                oldOrYoung = "old"
            } else {
                oldOrYoung = "young"
            }
        }
    }
    
    // 초기화 구문
    // 클래스나 구조체 또는 열거형의 인스턴스를 사용하기 위한 준비 과정
    // 따로 정의 안해도 빈함수가 생김!!
    init(sex: String) {
        self.sex = sex
        print("멍뭉이 생성!")
    }
    // 초기화 구문
    // 클래스나 구조체 또는 열거형의 인스턴스를 사용하기 위한 준비 과정

    /*
    init(매개변서: 타입, ... ) {
        // 프로퍼티 초기화
        // 인서턴스 생성시 필요한 설정을 해주는 코드 작성
    }
    */
    init(name: String, age: Int, sex: String){
        self.name = name
        self.age = age
        self.sex = sex
        print("멍뭉이 생성! \(name) \(age)")
    }
    
    init(name: String, sex: String){
        self.name = name
        self.age = 0
        self.sex = sex
        print("멍뭉이 생성! \(name) \(age)")
    }

    //deinitializer 클래스에서만 구현가능
    deinit {
        print("deinit dog")
    }
    func information() {
        print("\(name) \(age)")
    }
}


var dog = Dog(sex: "male") // init 함수 생성
dog.name = "망뭉"
dog.age = 8

var dog2 = Dog(name: "꾸꾸", age: 5, sex: "male")

var dog3 = Dog(name: "뉴뉴", sex: "female")

dog.information()
// get
dog.propertyAge
// set            //get
dog.propertyAge = dog.propertyAge
dog.information()
dog2.information()
dog3.information()

var dog4: Dog? = Dog(name: "뽀삐", age: 4, sex: "male")
// Swift는 instance가 더 이상 필요하지 않으면 자동으로 메모리에서 해제 시켜버리기 위해서 deinit 호출
dog4 = nil

// 구조체는 let로 선언시 프로퍼티가 var여도 변경 불가능!
// 클래스는 let로 선언해도 프로퍼티가 var이면 변경 가능!
// 구조체는 value타입이기 때문
// 클래스는 참조타입이기 때믄
let dog5 = Dog(name: "삐삐", age: 3, sex: "female")
dog5.name = "삐뽀"
dog5.information()

struct Cat{
    var name: String
    let sex: String
}

let cat = Cat(name: "랑이", sex: "male")
//cat.name = "아랑이" // 불가능!!


// 타입 프로퍼티
// 타입 이름과 '.' 연산자를 이용하여 접근가능
// 변수에 클래스를 인스턴스를 할당하지 않더라도 사용가능!
class SomeClass {
    static var myStoredProp = "Some Val"
    static var myComputedProp: Int {
        return 10
    }
}

SomeClass.myComputedProp
SomeClass.myStoredProp = "hello"
SomeClass.myStoredProp
