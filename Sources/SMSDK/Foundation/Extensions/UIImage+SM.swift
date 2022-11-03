//
//  UIImage+SM.swift
//  SMSDK
//
//  Created by Fernando León on 3/27/20.`
//  Copyright © 2020 Fernando León. All rights reserved.
//

import UIKit

extension UIImage {
    var encodeToBase64String: String? {
        return self.resizeImage()?.jpegData(compressionQuality: 1.0)?.base64EncodedString()
    }
    
    func resizeImage() -> UIImage? {
        var actualHeight: CGFloat = self.size.height
        var actualWidth: CGFloat = self.size.width
        let maxHeight: CGFloat = 600.0
        let maxWidth: CGFloat = 800.0
        var imgRatio: CGFloat = actualWidth/actualHeight
        let maxRatio: CGFloat = maxWidth/maxHeight
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }

        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
