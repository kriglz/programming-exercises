import UIKit

func directionForStep(_ step: Character) -> Int {
    return step == "U" ? 1 : -1
}

func countingValleys(n: Int, s: String) -> Int {
    var valleyCount = 0
    
    var direction = 0
    var total = 0
    
    for step in s {
        let stepDirection = directionForStep(step)
        
        // Define current direction
        if direction == 0 {
            direction = stepDirection
        }
        
        // Track sum
        total += stepDirection

        if total == 0 {
            // Count valley if one
            valleyCount += direction < 0 ? 1 : 0
            
            // Reset direction
            direction = 0
        }
    }
    
    return valleyCount
}

let n = 8
let s = "UDDDUDUU"
let valleys = countingValleys(n: n, s: s)

/*
    mountains:
        up == down
 
        no valleys if abow sea level up + down > 0
 
    valley:
        down == up
        
        no moubtains if below sea level down + up < 0
 
 
    need to know initial direction, and sum
 */
