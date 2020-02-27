import UIKit

func repeatedString(s: String, n: Int) -> Int {
    var aCount = 0
    
    var aInSCount = 0
    for character in s where character == "a" {
        aInSCount += 1
    }
    
    let sRepeatCount = n.quotientAndRemainder(dividingBy: s.count)

    aCount += aInSCount * sRepeatCount.quotient
    
    var index = 0
    for character in s {
        guard index < sRepeatCount.remainder else { break }
       
        if character == "a" {
            aCount += 1
        }
        
        index += 1
    }
    
    return aCount
}

let s = "aba"
let n = 10
let result = repeatedString(s: s, n: n)

let s2 = "a"
let n2 = 1000000000000
let result2 = repeatedString(s: s2, n: n2)


/*
 
 aba aba aba a...ba aba
 7 a's
 
 
 Solution:
 
 1. count a's in initial string s
 2. find how many times string fully repeats itself
 3. find how many times a is repeated in last not fully repeated string
 
 */
