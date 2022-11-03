//
//  UIFont+Extension.swift
//  
//
//  Created by Daniel Crespo Duarte on 25/10/22.
//

import UIKit

extension UIFont {
    
    static func loadFontWith(name: String) {
        let bundle = Bundle.module
        let pathForResourceString = bundle.path(forResource: name, ofType: "ttf")
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>? = nil
        
        if (CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false) {
            NSLog("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
    
    public static let loadMyFonts: () = {
        loadFontWith(name: ConstantsUi.Font.black)
        loadFontWith(name: ConstantsUi.Font.blackItalic)
        loadFontWith(name: ConstantsUi.Font.bold)
        loadFontWith(name: ConstantsUi.Font.boldItalic)
        loadFontWith(name: ConstantsUi.Font.extraLight)
        loadFontWith(name: ConstantsUi.Font.extraLightItalic)
        loadFontWith(name: ConstantsUi.Font.italic)
        loadFontWith(name: ConstantsUi.Font.light)
        loadFontWith(name: ConstantsUi.Font.lightItalic)
        loadFontWith(name: ConstantsUi.Font.regular)
        loadFontWith(name: ConstantsUi.Font.semiBold)
        loadFontWith(name: ConstantsUi.Font.semiBoldItalic)
    }()
}

