import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var tempCount = ""
        var decryptedString = ""
        var numbers = [String]()
        var repeatedPart = [String]()
        
        for symbol in message {
            if symbol.isNumber {
                tempCount = "\(tempCount)\(symbol)"
            } else if symbol == "[" {
                if tempCount == "" {
                    numbers.append("1")
                } else {
                    numbers.append(tempCount)
                }
                tempCount = ""
                repeatedPart.append(decryptedString)
                decryptedString = ""
            } else if symbol == "]" {
                var tempString = ""
                if let counts = Int(numbers.popLast() ?? "1") {
                    for _ in 0..<counts {
                        tempString += decryptedString
                    }
                }
                decryptedString = repeatedPart.popLast()! + tempString
            } else if symbol.isLetter {
                decryptedString += String(symbol)
            }
        }
        return decryptedString
    }
}
