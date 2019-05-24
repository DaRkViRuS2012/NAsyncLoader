//
//  UIImageView+NAsyncLoader.swift
//  NAsyncLoader
//
//  Created by Nour  on 5/23/19.
//  Copyright © 2019 Nour . All rights reserved.
//

import UIKit
import  NAsyncLoader

extension UIImageView{
    
    func loadFrom(url:String,placeHolder:UIImage?){
        if let nsUrl = URL(string: url) {
            let loader  = NAsyncURLLoader<UIImage>()
            loader.requestResource(from: nsUrl) { (result, _) in
                switch result{
                case .empty:
                    if let image = placeHolder{
                        self.setImage(image, animated: true, success: nil)
                    }
                    break
                case .error(let error):
                    print(error.localizedDescription)
                    self.image = UIImage(named: "error")
                    break
                case .success(let image):
                    self.image = image
                    break
                    
                }
            }
        }
    }
    
    func setImage(_ image : UIImage, animated : Bool, success succeed : ((UIImage) -> ())?) {
        
        if let succeed = succeed {
            succeed(image)
        } else if animated {
            UIView.transition(with: self, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.image = image
            }, completion: nil)
        } else {
            self.image = image
        }
    }
    
}
