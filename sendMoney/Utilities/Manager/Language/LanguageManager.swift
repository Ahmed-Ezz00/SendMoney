//
//  LanguageManager.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

import UIKit

class LanguageManager {
    
     static let shared = LanguageManager()
    
    private let kAppleLanguages = "AppleLanguages"
    private let kAppLanguages = "AppLanguage"
    private let userDefaults = UserDefaults.standard
    
     func saveNewLanguage(language: Language) {
        userDefaults.setValue([language.rawValue], forKey: kAppleLanguages)
        userDefaults.setValue(language.rawValue, forKey: kAppLanguages)
        userDefaults.synchronize()
    }
    
     func isRTL()-> Bool {
        return getCurrentLanguage() == .arabic
    }
    
     func getCurrentLanguage()-> Language {
        if let savedLanguage = UserDefaults.standard.string(forKey: kAppLanguages), let language = Language(rawValue: savedLanguage)  {
            return language
        } else {
            return .english
        }
    }
    
   
     func switchLanguage(language: Language) {
        var local = UISemanticContentAttribute.forceLeftToRight
        if language == .arabic {
            local = UISemanticContentAttribute.forceRightToLeft
        } else {
           local = UISemanticContentAttribute.forceLeftToRight
        }
        
        UIView.appearance().semanticContentAttribute = local
        UIButton.appearance().semanticContentAttribute = local
        UIButton.appearance().semanticContentAttribute = local
        UILabel.appearance().semanticContentAttribute = local
         
         let mainWindow = UIApplication.shared.mainWindow
         mainWindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
         UIView.transition(with: mainWindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { [weak self]() -> Void in
             guard let _ = self else{return}
         }) {[weak self] _ in
             guard let _ = self else{return}
             mainWindow.rootViewController = UIApplication.shared.rootViewController
             mainWindow.makeKeyAndVisible()
         }
     }
}
