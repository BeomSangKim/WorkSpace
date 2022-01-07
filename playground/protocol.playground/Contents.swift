import UIKit

// protocol
// 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진

/*
 protocol 이름 {
    // protocol 요구사항
 }
 */

protocol PersonProtocol{
    var propertyName: String { get set }
    var propertyAge: Int { get }
    init(someParameter: Int)
}

protocol NamingProtocol{
    var propertyFullName: String { get set }
    func printFullName()
}

struct manStructure: PersonProtocol, NamingProtocol {
    var name: String = ""
    var age: Int = 0
    var fullName: String = ""
    var propertyName: String {
        get {
            return self.name
        }
        set {
            self.name = newValue
        }
    }
    var propertyAge: Int {
        get {
            return self.age
        }
        set {
            self.age = newValue
        }
    }
    init(someParameter: Int) {
    }
    
    var propertyFullName: String {
        get {
            return fullName
        }
        set {
            
        }
    }
    func printFullName() {
        print(fullName)
    }
    
}


/*
class SomeClass : 슈퍼클래스먼저, 프로토콜나중에 {
 
 }
 */

