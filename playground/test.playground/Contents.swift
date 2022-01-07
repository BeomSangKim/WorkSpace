
import Foundation

struct NumbersForSort {
    var originalNumber:Int = 0
    var sortingNumber:Int = 0
}

func solution(_ numbers:[Int]) -> String {
    
    var numbersForSort:NumbersForSort = NumbersForSort()
    var numbersForSortArray:[NumbersForSort] = [NumbersForSort]()
    var answer:String = ""
    for i in numbers {
        var i = i
        var j = i
        numbersForSort.originalNumber = i
        while j > 10 {
            j /= 10
        }
        while i < 1000 {
            i = i * 10 + j
        }
        numbersForSort.sortingNumber = i
        numbersForSortArray.append(numbersForSort)
    }
    print(numbersForSortArray)
    let sortedArray = numbersForSortArray.sorted(by: {(numbersForSort1:NumbersForSort, numbersForSort2:NumbersForSort) -> Bool in
        return numbersForSort1.sortingNumber > numbersForSort2.sortingNumber
    })
    print(sortedArray)
    
    for sortedNumber in sortedArray {
        answer += "\(sortedNumber.originalNumber)"
    }
    return answer
}

solution([3, 30, 34, 5, 9, 1000])
