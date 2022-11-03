//
//  ConstantsUi.swift
//  
//
//  Created by Daniel Crespo Duarte on 25/10/22.
//

import UIKit
import Foundation

struct ConstantsUi {
    struct Font {
        static let black = "SourceSansPro-Black"
        static let blackItalic = "SourceSansPro-BlackItalic"
        static let bold = "SourceSansPro-Bold"
        static let boldItalic = "SourceSansPro-BoldItalic"
        static let extraLight = "SourceSansPro-ExtraLight"
        static let extraLightItalic = "SourceSansPro-ExtraLightItalic"
        static let italic = "SourceSansPro-Italic"
        static let light = "SourceSansPro-Light"
        static let lightItalic = "SourceSansPro-LightItalic"
        static let regular = "SourceSansPro-Regular"
        static let semiBold = "SourceSansPro-SemiBold"
        static let semiBoldItalic = "SourceSansPro-SemiBoldItalic"
    }
    
    struct Colors {
        static let background: UIColor = .init(hexString: "#F5F5F5")
        static let black: UIColor = .init(hexString: "#333333")
        static let blue: UIColor = .init(hexString: "#0067B1")
        static let lightBlue: UIColor = .init(hexString: "#E2E8EE")
        static let white: UIColor = .init(hexString: "#FFFFFF")
        static let grayDark: UIColor = .init(hexString: "#757575")
    }
    
    struct Images {
        static let iconBack: UIImage? = UIImage(named: "iconBack", in: Bundle.module, compatibleWith: nil)
        static let iconClose: UIImage? = UIImage(named: "iconClose", in: Bundle.module, compatibleWith: nil)
        static let frontId: UIImage? = UIImage(named: "frontId", in: Bundle.module, compatibleWith: nil)
        static let sideId: UIImage? = UIImage(named: "sideId", in: Bundle.module, compatibleWith: nil)
        static let iconAttention: UIImage? = UIImage(named: "iconAttention", in: Bundle.module, compatibleWith: nil)
        static let iconErrorClose: UIImage? = UIImage(named: "iconErrorClose", in: Bundle.module, compatibleWith: nil)
        static let iconCouldNotTakePhoto: UIImage? = UIImage(named: "iconCouldNotTakePhoto", in: Bundle.module, compatibleWith: nil)
        static let iconValidateId: UIImage? = UIImage(named: "iconValidateId", in: Bundle.module, compatibleWith: nil)
    }
}
