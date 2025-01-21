//
//  Language.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

enum Language: String {
    case english = "en"
    case arabic = "ar"
    
    var title: String {
        switch self {
        case .english:
            return "English"
        case .arabic:
            return "العربية"
        }
    }
}
