//
// AppFonts.swift
//  NAsyncLoader
//
//  Created by Nour  on 5/23/19.
//  Copyright © 2019 Nour . All rights reserved.
//
import UIKit

struct AppFonts {
    // MARK: fonts names
    private static let fontNameBoldEN = "HelveticaNeue-Bold"
    private static let fontNameSemiBoldEN = "HelveticaNeue-Medium"
    private static let fontNameRegularEN = "HelveticaNeue"
    

    // MARK: font sizes
    private static var sizeXBig:Double {
        return 26
    }
    
    private static var sizeBig:Double {
        return 20
    }
    
    private static var sizeNormal:Double{
        return 18
    }
    
    private static var sizeSmall:Double{
        return 14
    }
    
    private static var sizeXSmall:Double{
        return 12
    }

    private enum FontWeight {
        case bold
        case semiBold
        case regular
    }

    // MARK: fonts getters
    // font to be used in the app
    static var xBig: UIFont {
        let fontName = getFontName(weight:.regular)
        return UIFont(name: fontName, size: CGFloat(sizeXBig * fontScale))!
    }

    static var xBigBold: UIFont {
        let fontName = getFontName(weight:.bold)
        return UIFont(name: fontName, size: CGFloat(sizeXBig * fontScale))!
    }

    static var xBigSemiBold: UIFont {
        let fontName = getFontName(weight:.semiBold)
        return UIFont(name: fontName, size: CGFloat(sizeXBig * fontScale))!
    }

    static var big: UIFont {
        let fontName = getFontName(weight:.regular)
        return UIFont(name: fontName, size: CGFloat(sizeBig * fontScale))!
    }

    static var bigBold: UIFont {
        let fontName = getFontName(weight:.bold)
        return UIFont(name: fontName, size: CGFloat(sizeBig * fontScale))!
    }

    static var bigSemiBold: UIFont {
        let fontName = getFontName(weight:.semiBold)
        return UIFont(name: fontName, size: CGFloat(sizeBig * fontScale))!
    }

    static var normal: UIFont {
        let fontName = getFontName(weight:.regular)
        return UIFont(name: fontName, size: CGFloat(sizeNormal * fontScale))!
    }

    static var normalBold: UIFont {
        let fontName = getFontName(weight:.bold)
        return UIFont(name: fontName, size: CGFloat(sizeNormal * fontScale))!
    }

    static var normalSemiBold: UIFont {
        let fontName = getFontName(weight:.semiBold)
        return UIFont(name: fontName, size: CGFloat(sizeNormal * fontScale))!
    }

    static var small: UIFont {
        let fontName = getFontName(weight:.regular)
        return UIFont(name: fontName, size: CGFloat(sizeSmall * fontScale))!
    }

    static var smallBold: UIFont {
        let fontName = getFontName(weight:.bold)
        return UIFont(name: fontName, size: CGFloat(sizeSmall * fontScale))!
    }

    static var smallSemiBold: UIFont {
        let fontName = getFontName(weight:.semiBold)
        return UIFont(name: fontName, size: CGFloat(sizeSmall * fontScale))!
    }

    static var xSmall: UIFont {
        let fontName = getFontName(weight:.regular)
        return UIFont(name: fontName, size: CGFloat(sizeXSmall * fontScale))!
    }

    static var xSmallBold: UIFont {
        let fontName = getFontName(weight:.bold)
        return UIFont(name: fontName, size: CGFloat(sizeXSmall * fontScale))!
    }

    static var xSmallSemiBold: UIFont {
        let fontName = getFontName(weight:.semiBold)
        return UIFont(name: fontName, size: CGFloat(sizeXSmall * fontScale))!
    }

    // Font scale
    private static var fontScale:Double {
        var scale : Double = 1.0;
        if (ScreenSize.isSmallScreen) {    // iPhone 4 & 5 (480 - 568)
            scale = 0.8;
        } else if (ScreenSize.isMidScreen){ // iPhone 6 & 7 (667)
            scale = 0.95;
        } else {                    // iPhone 6+ & 7+ (736)
            scale = 1.0;
        }
        return scale;
    }

    private static func getFontName(weight: FontWeight) -> String {
            switch weight {
            case .bold:
                return fontNameBoldEN
            case .semiBold:
                return fontNameSemiBoldEN
            default:
                return fontNameRegularEN
            }
        }
}
