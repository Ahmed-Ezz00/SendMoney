//
//  UIApplication+Ex.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

import UIKit

extension UIApplication {
    var mainWindow: UIWindow {
        return self.windows.filter{$0.isKeyWindow}.first ?? .init()
    }
    var rootViewController: UIViewController {
        
        let viewModel = LoginViewModel(currentUser: .init(email: "testuser", password: "password123"), loginErrorMessage: UIStrings.signInError.localized)
        let viewController = LoginViewController(viewModel: viewModel)
        return BaseNavigationController(rootViewController: viewController)
    }
}
