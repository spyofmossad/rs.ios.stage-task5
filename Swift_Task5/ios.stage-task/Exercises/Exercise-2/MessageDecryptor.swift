import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        
        var input = message
        var output: String = ""
        
        while input.count > 0 {
            var item = String(input.prefix(while: {$0 != "["}))
            if let multiplier = Int(item) {
                let firstRange = input.range(of: item)
                input = input.replacingCharacters(in: firstRange!, with: "")
                
                let subMessage = getSubMessage(of: input)
                let decryprted = decryptMessage(subMessage)
                
                output.append(String(repeating: decryprted, count: multiplier))
                
                let secondRange = input.range(of: subMessage)
                input = input.replacingCharacters(in: secondRange!, with: "")
            } else {
                item = String(input.first!)
                if item != "]" && item != "[" {
                    output.append(item)
                }
                input = String(input.dropFirst())
            }
        }
        
        return output
    }
    
    private func getSubMessage(of message: String) -> String {
        
        var subMessage = ""
        var counter = 0
        
        for char in message {
            subMessage.append(char)
            if char != "]" {
                if char == "[" {
                    counter += 1
                }
            } else {
                counter -= 1
                if counter == 0 {
                    break
                }
            }
        }
        return subMessage
    }
}
