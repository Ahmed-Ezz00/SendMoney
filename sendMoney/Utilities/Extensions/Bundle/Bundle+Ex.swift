//
//  Bundle+Ex.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

import UIKit

extension Bundle {
    static var localizedBundle: Bundle {
        let languageCode = LanguageManager.shared.getCurrentLanguage().rawValue
        guard let
                path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}
