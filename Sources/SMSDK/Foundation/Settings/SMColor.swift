import UIKit

struct SMColor {
    static let backgroundColor = UIColor(red: 25/255, green: 29/255, blue: 43/255, alpha: 1.0)
    static let textColor = UIColor(red: 133/255, green: 145/255, blue: 165/255, alpha: 1.0)
    static let acuantBackgroundColor = UIColor(red: 25/255, green: 29/255, blue: 43/255, alpha: 0.85)
    static let blueBackgroundColor = UIColor(red: 31/255, green: 38/255, blue: 51/255, alpha: 1.0)
    
    
    static func prepareColor(color: String) -> String{
        var prepareColor = color
        do {
            if color.count == 9{
                let fullcolor = color.substring(with: 1..<7)
                let transparency = color.replacingOccurrences(of: fullcolor, with: "")
                prepareColor = transparency + fullcolor
            }
        try UIColor(hexString: prepareColor)
        } catch {
            NSLog("error en SMColor: \(error)")
            prepareColor = "#ffffff"
        }
        
        return prepareColor
    }
}
