import UIKit

//func minimumBribes(q: [Int]) -> Void {
//    var bribeCount = 0
//
//    for currentPosition in 0..<q.count {
//        let initialPositionInQueue = q[currentPosition] - 1
//
//        // Imposible case, too far ahead
//        if initialPositionInQueue > currentPosition + 2 {
//            return print("Too chaotic")
//        }
//
//        for nextPosition in (currentPosition + 1)..<q.count {
//            if q[currentPosition] > q[nextPosition] {
//                bribeCount += 1
//            }
//        }
//    }
//
//    print(bribeCount)
//}

func minimumBribes(q: [Int]) -> Void {
    var bribeCount = 0
    
    for currentPosition in 0..<q.count {
        let initialPositionInQueue = q[currentPosition] - 1
                
        // Imposible case, too far ahead
        if initialPositionInQueue > currentPosition + 2 {
            return print("Too chaotic")
        }
        
        let delta = initialPositionInQueue - currentPosition
        if delta > 0 {
            bribeCount += delta
            
        } else {
            for nextPosition in (currentPosition + 1)..<q.count {
                if q[currentPosition] > q[nextPosition] {
                    bribeCount += 1
                }
            }
        }
    }
    
    print(bribeCount)
}

let queue1 = [2, 5, 1, 3, 4] // not possible
let queue2 = [2, 1, 5, 3, 4] // 3
let queue3 = [2, 1, 5, 4, 3] // 4
let queue4 = [1, 2, 5, 3, 7, 8, 6, 4] // 7

minimumBribes(q: queue1)
minimumBribes(q: queue2)
minimumBribes(q: queue3)
minimumBribes(q: queue4)

/*
 
 1, 2, 3, 4, 5
 2, 1, 3, 4, 5

 2, 3, 1, 4, 5

 2, 1, 3, 5, 4
 2, 1, 5, 3, 4
 2, 1, 3, 5, 4

 
 2, 5, 1, 3, 4
 
 You can more front by 2, you can move back by any number
 
 
 12345
 31245
 34125
 34512
 
 */
