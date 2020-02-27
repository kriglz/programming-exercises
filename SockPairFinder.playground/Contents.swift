import UIKit

func sockMerchant(n: Int, ar: [Int]) -> Int {
    var sockList = [Int: Int]()
    
    for index in 0..<n {
        sockList[index] = ar[index]
    }

    var pairCount = 0
    
    for index in 0..<n {
        if sockList[index] == nil {
            continue
        }
        
        sockList.removeValue(forKey: index)
        
        let sock = ar[index]
        
        for (unpairedSockIndex, unpairedSock) in sockList {
            if sock == unpairedSock {
                sockList.removeValue(forKey: unpairedSockIndex)
                pairCount += 1
                break
            }
        }
    }
    
    return pairCount
}

func sockMerchant2(n: Int, ar: [Int]) -> Int {
    var sockList = [Int: Int]()
    var pairCount = 0

    for sockIndex in 0..<n {
        let sockColor = ar[sockIndex]
        
        if sockList[sockColor] == nil {
            sockList[sockColor] = 1
        } else {
            sockList[sockColor]! += 1
        }
    }
    
    for (_, sockCount) in sockList {
        print(sockCount, sockCount / 2)
        pairCount += sockCount / 2
    }
    
    return pairCount
}

let n = 9
let ar = [10, 20, 20, 10, 10, 30, 50, 10, 20]
let pairCount = sockMerchant(n: n, ar: ar)
let pairCount2 = sockMerchant2(n: n, ar: ar)
