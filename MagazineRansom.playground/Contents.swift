import UIKit

//func checkMagazine(magazine: [String], note: [String]) -> Void {
//    var magazineList = [Character: [String]]()
//
//    for word in magazine {
//        guard let firstLetter = word.first else { continue }
//
//        if magazineList[firstLetter] == nil {
//            magazineList[firstLetter] = [word]
//        } else {
//            magazineList[firstLetter]?.append(word)
//        }
//    }
//
//    for word in note {
//        guard let firstLetter = word.first else { continue }
//
//        guard let magazineWords = magazineList[firstLetter], !magazineWords.isEmpty else {
//            print("No")
//            return
//        }
//
//        var wordExists = false
//        for index in 0..<magazineWords.count {
//            if word == magazineWords[index] {
//                magazineList[firstLetter]?.remove(at: index)
//                wordExists = true
//                break
//            }
//        }
//
//        if wordExists == false {
//            print("No")
//            return
//        }
//    }
//
//    print("Yes")
//}

func wordHashValue(_ word: String) -> Int {
    var sum = 0
    for char in word {
        sum += Int(char.asciiValue ?? 0)
    }
    return sum
}

func checkMagazine(magazine: [String], note: [String]) -> Void {
    var magazineList = [Int: [Int]]()
    
    for index in 0..<magazine.count {
        let word = magazine[index]
        let wordHash = wordHashValue(word)
        
        if magazineList[wordHash] == nil {
            magazineList[wordHash] = [index]
        } else {
            magazineList[wordHash]?.append(index)
        }
    }
        
    for word in note {
        let wordHash = wordHashValue(word)
        
        guard let magazineWorldIndices = magazineList[wordHash], !magazineWorldIndices.isEmpty else {
            print("No")
            return
        }
        
        var wordExists = false
        var indexIndex = 0
        for index in magazineWorldIndices {
            if word == magazine[index] {
                magazineList[wordHash]?.remove(at: indexIndex)
                wordExists = true
                break
            }
            
            indexIndex += 1
        }
        
        if wordExists == false {
            print("No")
            return
        }
    }
    
    print("Yes")
}

let magazine = ["give", "me", "one", "grand", "today", "give", "night"]
let note = ["give", "one", "grand", "today"]
checkMagazine(magazine: magazine, note: note)

// M + N * M * 5
// M * 5 + N * M * 5
