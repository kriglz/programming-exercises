import UIKit

func jumpingOnClouds(c: [Int]) -> Int {
    var jumpCount = 0
    var currentCloudIndex = 0

    let cloudNumber = c.count
    
    func nextCloud(forCloud: Int) -> Int {
        let nextCloud = forCloud + 2
        if cloudNumber > nextCloud, c[nextCloud] == 0 {
            return nextCloud
        
        }

        return nextCloud - 1
    }
    
    while currentCloudIndex < cloudNumber - 1 {
        currentCloudIndex = nextCloud(forCloud: currentCloudIndex)
        jumpCount += 1
    }

    return jumpCount
}

let n = 7
let c = [0, 0, 1, 0, 0, 1, 0]
let jumps = jumpingOnClouds(c: c)

/*
 
 try CLOUD + 2 if fails try + 1, IF exists
 
 */
