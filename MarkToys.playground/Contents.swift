import UIKit

var str = "Hello, playground"

// Prices can't repeat
func maximumToys(uniquePrices: [Int], k: Int) -> Int {
    var toys = 0
        
    var relevantToyList = [Int: Int]()
    for price in uniquePrices {
        if price <= k {
            relevantToyList[price] = price
        }
    }
    
    var totalPrice = 0
    for i in 1...k {
        let relevantPrice = relevantToyList[i]

        guard let price = relevantPrice else {
            continue
        }
        
        if price + totalPrice <= k {
            totalPrice += price
            toys += 1
        } else {
            break
        }
    }
    
    return toys
}

func maximumToys(prices: [Int], k: Int) -> Int {
    let pricesSorted = prices.sorted()

    var toys = 0
    var totalPrice = 0
    
    for price in pricesSorted {
        if price + totalPrice <= k {
            totalPrice += price
            toys += 1
        } else {
            break
        }
    }

    return toys
}

let budget = 50
//let prices = [1, 12, 5, 2, 3, 4, 6, 7, 8, 9, 11, 13, 14, 15, 16, 20, 21, 22, 23, 111, 200, 1000, 10]
let prices = [1, 12, 5, 111, 200, 1000, 10]
//let prices = [5, 5]
let toyCount = maximumToys(prices: prices, k: budget)
