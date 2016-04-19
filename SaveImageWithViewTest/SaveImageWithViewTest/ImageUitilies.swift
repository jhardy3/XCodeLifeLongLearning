//
//  ImageUitilies.swift
//  Tine
//
//  Created by Jake Hardy on 3/24/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ImageUitilies: NSObject {

    static func cropToSquare(image originalImage: UIImage) -> UIImage {
        let contextImage: UIImage = UIImage(CGImage: originalImage.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            width = contextSize.height
            height = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            width = contextSize.width
            height = contextSize.width
        }

        let rect: CGRect = CGRectMake(posX, posY, width, height)
        
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        let image: UIImage = UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        return image
    }
    
    static func createImageWithViewOnTop(backgroundImage image: UIImageView, view: UIView) -> UIImage? {
        image.addSubview(view)
        
        UIGraphicsBeginImageContextWithOptions(image.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        image.layer.renderInContext(context)
        
        let imageToSave = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        return imageToSave
    }
    
}

extension UIImageView {
    
    func downloadImageFrom(link link:String, contentMode: UIViewContentMode) {
        NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

