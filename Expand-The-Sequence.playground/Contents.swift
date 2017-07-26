//You are given an array numbers. Expand the numbers into an a palindrome landscape of mountains. For numbers = [2,3,2,4], palindromeMountains = [1,2,1,2,3,1,2,1,2,3,4,3,2,1]

let numbers = [2,3,1,4,1,1]

var newNumbers = [Int]()
//var newNumbersNumber = 0

for n in 0..<numbers.count {
    
    
    if numbers[n] != 1 {
//increacement sequence
        var increacement = 1
        while increacement <= numbers[n] {
            newNumbers.append(increacement)
            increacement += 1
            //            newNumbersNumber += 1
        }
        
//decreacement to 2 sequence
        increacement -= 1
        while increacement > 2 {

                increacement -= 1
                newNumbers.append(increacement)
//                newNumbersNumber += 1
            }
        if n == numbers.count - 1 {
            newNumbers.append(1)
        
        }
    } else {
        if n == numbers.count - 1 {
            newNumbers.append(1)
        }
    }
}
print(newNumbers)

func palindromeSequence(numbers:[Int]) -> [Int] {
    var mountains = [Int]()
    for i in 0..<numbers.count {
        var j = 1
        if i != 0 {j = 2}
        while j <= numbers[i] {
            mountains.append(j)
            j += 1
        }
        j -= 1
        repeat {
            j -= 1
            mountains.append(j)
        } while j > 1
        
    }
    return mountains
}

var palindromeMountains = palindromeSequence(numbers: numbers)
print(palindromeMountains)