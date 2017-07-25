import Cocoa

func blowOutCandleNumber(input: String) -> Int
{
    let n = input.components(separatedBy: "\n")

    let h = n[1].components(separatedBy: " ").map{ (Int(String(describing: $0))!)}

    let totalCandleNumber = Int(String(n[0]))!
    var iCandleHeight = [Int]()
    var numberOfBLowOutCandles = 0
    
    for i in 0..<totalCandleNumber {
        iCandleHeight.append(h[i])
    }
    let highestCandle = iCandleHeight.max()!
    for every in iCandleHeight {
        if every == highestCandle {
            numberOfBLowOutCandles += 1
        }
    }
    return numberOfBLowOutCandles
}

let sampleInput0 = "4\n3 2 1 3"
let sampleOutpur0 = 2
sampleOutpur0 == blowOutCandleNumber(input: sampleInput0)

let sampleInput1 = "7\n3 9 1 9 5 6 9"
let sampleOutpur1 = 3
sampleOutpur1 == blowOutCandleNumber(input: sampleInput1)

let sampleInput2 = "17\n3 9 1 9 5 6 9 9 9 9 9 8 7 8 7 6 5"
let sampleOutpur2 = 7
sampleOutpur2 == blowOutCandleNumber(input: sampleInput2)
