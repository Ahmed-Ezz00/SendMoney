//
//  String+Ex.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//
import UIKit

extension String {
    var localized: String {
        return Bundle.localizedBundle.localizedString(forKey: self, value: self, table: "Localizable")
    }
}


