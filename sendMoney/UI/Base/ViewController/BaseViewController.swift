//
//  BaseViewController.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

import UIKit

class BaseViewController: UIViewController {
    private var newLanguage: Language {
        LanguageManager.shared.getCurrentLanguage() == .english ? .arabic : .english
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        removeBackButtonTitle()
        addLanguageButton()
    }
    
    func showError(_ error: CustomError) {
        let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: UIStrings.alertControllerActionOk.localized, style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    deinit {
        print("\(self) is deallocated from memory")
    }
    
}

private extension BaseViewController {
    func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: self, action: nil)
    }

    func addLanguageButton() {
        let buttonItem = UIBarButtonItem(title: newLanguage.title, style: .plain, target: self, action: #selector(changeLanguage))
        let buttonAttributes = [NSAttributedString.Key.font: UIFont.title, NSAttributedString.Key.foregroundColor: UIColor.navigationTintColor]
        buttonItem.setTitleTextAttributes(buttonAttributes, for: .normal)
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    @objc
    func changeLanguage() {
        LanguageManager.shared.switchLanguage(language: newLanguage)
        LanguageManager.shared.saveNewLanguage(language: newLanguage)
    }
}
