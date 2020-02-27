import UIKit

func hourglassSum(arr: [[Int]]) -> Int {
    let hourflassSize = 3

    var sumMax = -Int.max

    let rows = arr.count
    let columns = arr[0].count
    
    let rowOptions = rows + 1 - hourflassSize
    let columnOptions = columns + 1 - hourflassSize

    for index in 0..<rowOptions * columnOptions {
        let divisionResult = index.quotientAndRemainder(dividingBy: rowOptions)
        let row = divisionResult.quotient
        let column = divisionResult.remainder
        
        let sum = arr[row][column] + arr[row][column + 1] + arr[row][column + 2]
                + arr[row + 1][column + 1]
                + arr[row + 2][column] + arr[row + 2][column + 1] + arr[row + 2][column + 2]
        
        if sum > sumMax {
            sumMax = sum
        }
    }
    
    return sumMax
}

let array = [[1, 1, 1, 0, 0, 0],
             [0, 1, 0, 0, 0, 0],
             [1, 1, 1, 0, 0, 0],
             [0, 0, 2, 4, 4, 0],
             [0, 0, 0, 2, 0, 0],
             [0, 0, 1, 2, 4, 0]]

let sum = hourglassSum(arr: array)

/*
 
 1 1 1 0 0 0
 0 1 0 0 0 0
 1 1 1 0 0 0
 0 0 2 4 4 0
 0 0 0 2 0 0
 0 0 1 2 4 0
 
 Find hourglass (dimensions 3 by 3) with the maximum sum (19)
 
 */
