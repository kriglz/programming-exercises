//: Playground - noun: a place where people can play

import Cocoa

enum ArithmeticExpression {
    case number(Double)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
    indirect case sine(ArithmeticExpression)
}


func evaluate(_ expression: ArithmeticExpression) -> Double {
    switch expression {
    case let .number(value):
        return value
        
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
        
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
        
    case let .sine(e):
        return sin(evaluate(e))
    }
}

//func parse(input: String) -> ArithmeticExpression {
//    var expresion: ArithmeticExpression?
//    var expressionElement = input.components(separatedBy: " ")
//    
//    var numberArray = [ArithmeticExpression]()
//    var number: Int = 0
//    
//    for element in expressionElement {
//        switch element {
//        case "+":
//            ArithmeticExpression.addition(numberArray[0], numberArray[1])
//        case "5":
//            numberArray[number] = ArithmeticExpression.number(Double(element)!)
//            number += 1
//        }
//
//    }
//    
//    return expresion ?? .number(0.0)
//}

//let parseStringBe: String = "5 + 2"
//parse(input: parseStringBe)

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
product
print(evaluate(product))
let sine = ArithmeticExpression.sine(ArithmeticExpression.number(3.14))
print(evaluate(sine))
