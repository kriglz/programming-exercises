//You are given an array numbers. Expand the numbers into an a palindrome landscape of mountains. For numbers = [2,3,2,4], palindromeMountains = [1,2,1,2,3,1,2,1,2,3,4,3,2,1]

func palindromeSequence(_ numbers: [Int]) -> [Int] {
    var newNumbers = [Int]()
    
    for n in 0..<numbers.count {
        if numbers[n] != 1 {

            //increacement sequence
            var increacement = 1
            while increacement <= numbers[n] {
                newNumbers.append(increacement)
                increacement += 1
            }
            
            //decreacement to 2 sequence
            increacement -= 1
            while increacement > 2 {                
                increacement -= 1
                newNumbers.append(increacement)
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
    return newNumbers
}

let numbers0 = [2,3,1,4,1,1]
let palindromeNumbers0 = [1, 2, 1, 2, 3, 2, 1, 2, 3, 4, 3, 2, 1]
var palindromeMountains0 = palindromeSequence(numbers0)
palindromeNumbers0 == palindromeMountains0
print(palindromeMountains0)

let numbers1 = [2,3,2,4]
let palindromeNumbers1 = [1, 2, 1, 2, 3, 2, 1, 2, 1, 2, 3, 4, 3, 2, 1]
var palindromeMountains1 = palindromeSequence(numbers1)
palindromeNumbers1 == palindromeMountains1
