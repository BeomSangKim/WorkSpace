import Foundation

var combinationSet:[[Int]] = [[Int]]()
var currentSet:[Int] = [Int]()
func makeCombinationSet(_ currentDepth:Int, _ count:Int) {
    if currentDepth == count {
        if currentSet == [] {
            return
        }
        combinationSet.append(currentSet)
        return
    }
    
    currentSet.append(currentDepth + 1)
    makeCombinationSet(currentDepth + 1, count)
    currentSet.remove(at: currentSet.count - 1)
    makeCombinationSet(currentDepth + 1, count)
    
    
}

func solution(_ relation:[[String]]) -> Int {
    
    let count = relation[0].count
    makeCombinationSet(0, count)
    combinationSet.sort(by: {$0.count < $1.count})
    
    var answerSet:[Int] = [Int]()
    
    combinationLoop : for combination in combinationSet {
        var currentAnswer = 0
        for i in combination {
            currentAnswer += (1 << i)
        }
        
        for answer in answerSet {
            if answer&currentAnswer == answer {
                continue combinationLoop
            }
        }
        
        var dictionary:[String:Int] = [String:Int]()
        for relationShip in relation {
            var dicionaryKey = ""
            for i in combination {
                dicionaryKey += relationShip[i-1]
            }
            if dictionary[dicionaryKey] == 1 {
                continue combinationLoop
            }
            dictionary[dicionaryKey] = 1
        }
        
        answerSet.append(currentAnswer)
    }
    
    return answerSet.count
}

solution([["100","ryan","music","2"],["200","apeach","math","2"],["300","tube","computer","3"],["400","con","computer","4"],["500","muzi","music","3"],["600","apeach","music","2"]])
print()
