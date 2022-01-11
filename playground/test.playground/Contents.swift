import Foundation

var isVisited:[Int] = [Int]()
var numbersString:[String] = [String]()
var answer = "0"
var count = 0
var answerSet:Set<Int> = Set<Int>()

func isPrimeNumber(_ number: Int) {
    
    var res = true
    if number <= 1 {
        return
    }
    else if number <= 3 {
        return
    }
    for i in 2..<number/2 {
        if number % i == 0 {
            res = false
            break
        }
    }
    if res == true {
        answerSet.insert(number)
    }
}

func permutation() {
    var allVisited = true
    for i in isVisited {
        if i == 0 {
            allVisited = false
            break
        }
    }
    if allVisited == true {
        isPrimeNumber(Int(answer)!)
        return
    }
    
    for i in 0..<numbersString.count {
        if isVisited [i] == 0 {
            isVisited[i] = 1
            answer = answer + numbersString[i]
            permutation()
            if answer != ""{
                answer = String(answer[answer.index(answer.startIndex, offsetBy:0)..<answer.index(answer.endIndex, offsetBy:-1)])
            }
            permutation()
            isVisited[i] = 0
        }
    }
    
}
func solution(_ numbers:String) -> Int {
    
    for i in 0..<numbers.count {
        numbersString.append((String(numbers[numbers.index(numbers.startIndex, offsetBy: i)])))
        isVisited.append(0)
    }
    print(numbersString)
    print(isVisited)
    permutation()

    return answerSet.count
}

solution("17")
