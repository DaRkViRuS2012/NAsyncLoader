//
//  AppConfig.swift
//  NAsyncLoader
//
//  Created by Nour  on 5/23/19.
//  Copyright © 2019 Nour . All rights reserved.
//
import UIKit


// MARK: Application configuration
struct AppConfig {
    /// Set navigation bar style, text and color
    static func setNavigationStyle() {
        // set text title attributes
        let attrs = [NSAttributedString.Key.foregroundColor : UIColor.gray,
                     NSAttributedString.Key.font : AppFonts.xBigBold]
        UINavigationBar.appearance().titleTextAttributes = attrs
        // set background color
        UINavigationBar.appearance().barTintColor = .white//AppColors.blueXDark
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
}



// MARK: Screen size
enum ScreenSize {
    static let isSmallScreen =  UIScreen.main.bounds.height <= 568 // iphone 4/5
    static let isMidScreen =  UIScreen.main.bounds.height <= 667 // iPhone 6 & 7
    static let isBigScreen =  UIScreen.main.bounds.height >= 736 // iphone 6Plus/7Plus
    static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
}


