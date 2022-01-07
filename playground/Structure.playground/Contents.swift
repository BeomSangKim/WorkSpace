import UIKit

// 구조체
// struct 키워드를 사용하여 정의
/*
struct 구조체이름{
    프로퍼티와 메서드
}
*/

struct User{
    var nickname: String
    var age: Int
    
    func information() {
        print("\(nickname) \(age) 입니다!")
    }
}

// instance 생성 // 생성자를 따로 정의하지 않아도 생성자가 만들어진다!
var user1 = User(nickname: "밤슝이😝", age: 28)

user1.information()
user1.nickname = "아로밍🥰"
user1.age = 25
user1.information()

