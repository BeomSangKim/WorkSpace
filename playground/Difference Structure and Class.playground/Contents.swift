import UIKit

// 공통점
// 1. 값을 저장할 프로퍼티를 생성할 수 있다.
// 2. 함수적 기능을 하는 메서드를 생성할 수 있다.
// 3. 내부값에 .을 이용하여 접근 할 수 있다.
// 4. 생성자를 사용해 초기 상태를 설정할 수 있다.
// 5. extension을 사용하여 기능을 확장할 수 있다.
// 6. Protocol을 채택하여 기능을 설정할 수 있다.

// 차이점
// 클래스
// 1. 참조 타입이다. (stack영역에는 pointer만 할당되고 실제 데이터는 heap영역에 저장됨.)
class CarClass {
    var drivenDistance : Int = 0
}
// 2. ARC(Auto Reference Counting)로 메모리를 관리한다.
// 3. 타입 캐스팅을 통해 런타임에서 클래스 인스턴스의 타입을 확인할 수 있다.
// 4. deinit을 사용하여 클래스 인스턴스의 메모리 할당을 해제할 수 있다.
// 5. 같은 클래스 인스턴스를 여러개의 변수에 할당한 뒤 값을 변경 시키면 모든 변수에 영향을 준다. (메모리가 복사됨)
var carClass1: CarClass = CarClass()
var carClass2 = carClass1
var carClass3 = carClass1

carClass1.drivenDistance = 10
carClass2.drivenDistance
carClass3.drivenDistance

// 구조체
// 1. value 타입이다. (stack영역에 데이터가 저장됨.)
struct CarStruct {
    var drivenDistance : Int = 0
}
// 2. 구조체 변수를 새로운 변수에 할당할 때 마다 새로운 구조체가 할당됩니다.
// 3. 같은 구조체 변수를 여러개의 변수에 할당한 뒤 값을 변경시키더라도 다른 변수에 영향을 주지 않는다.
var carStruct1: CarStruct = CarStruct()
var carStruct2 = carStruct1
var carStruct3 = carStruct1

carStruct1.drivenDistance = 10
carStruct2.drivenDistance
carStruct3.drivenDistance

