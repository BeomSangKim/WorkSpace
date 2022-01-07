import Foundation

// Optional chaining
// 옵셔널에 속해 있는 nil 일지도 모르는 프로퍼티, 메서드, 서브스크립션 등을 가져오거나 호출할 때 사용할 수 있는 일련의 과정

struct Developer {
    let name: String
}

struct Company {
    let name: String
    var developer: Developer?
}

var company = Company(name: "밤슝컴퍼니", developer: nil)
print(company.developer)

var developer = Developer(name: "밤슝슝")
company.developer = developer

print(company.developer?.name) // 접근한 프로퍼티는 옵셔널이 유지
print(company.developer!.name) // 값을 강제로 옵셔널 벗김
