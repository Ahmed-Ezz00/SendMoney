//
//  BaseNavigationController.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarStyle()
    }
}

private extension BaseNavigationController {
    func setNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.navigationBarColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationTintColor, NSAttributedString.Key.font: UIFont.title]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = .navigationTintColor
    }
}
