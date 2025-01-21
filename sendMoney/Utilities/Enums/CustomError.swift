//
//  CustomError.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 20/01/2025.
//
import UIKit
public enum CustomError: Error {
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .custom(let message):
            return message
        }
    }
}
