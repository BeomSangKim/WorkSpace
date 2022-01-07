import UIKit

// 고차함수
// 다른 함수를 전달 인자로 받거나 함수 실행의 결과를 함수로 반환하는 함수
// swift의 함수는 일급객체이기 때문에 인자나 반환형으로 사용가능!

// map, filter, reduce

// map : 컨테이너 내부의 기존데이터를 변형하여 새로운 컨테이너를 생성한다.
let numbers = [0, 1, 2, 3]
let mapArray = numbers.map { (numbers) -> Int in
    return numbers * 3
}
print("map \(mapArray)")

// filter
let numbers2 = [0, 1, 2, 3, 0, 3, 4]
let filterArray = numbers2.filter { $0 > 1 }
print("filter \(filterArray)")

// reduce
var numbers3: [Int] = [Int]()
for i in 1...10 {
    numbers3.append(i)
}
let reduceArray = numbers3.reduce(0)/* 0은 result 초기값*/ {
    (result: Int, element: Int) -> Int in
    print("\(result) + \(element)")
    return result + element
}
