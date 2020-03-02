import UIKit

func makeAnagram(a: String, b: String) -> Int {
    var deletions = 0
    
    var aList = [Character: Int]()
    for char in a {
        if aList[char] == nil {
            aList[char] = 1
        } else {
            aList[char]! += 1
        }
    }
    
    var bList = [Character: Int]()
    for char in b {
        if bList[char] == nil {
            bList[char] = 1
        } else {
            bList[char]! += 1
        }
    }
    
    for (char, count) in aList {
        let charInBList = bList[char]
        
        if charInBList == nil {
            deletions += count
        } else {
            deletions += abs(charInBList! - count)
        }
        
        bList.removeValue(forKey: char)
    }
    
    for (_, count) in bList {
        deletions += count
    }
    
    return deletions
}

let a = "cde"
let b = "abc"
let deletions = makeAnagram(a: a, b: b)
