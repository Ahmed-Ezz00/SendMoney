//
//  LoginViewController.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var passwordTextField: CustomTextField!
    @IBOutlet private weak var emailTextField: CustomTextField!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var sendMoneyLabel: UILabel!
    @IBOutlet private weak var termsConditionsLabel: UILabel!

    private let viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = UIStrings.signInTitle.localized
        configureViews()
    }

    @IBAction private func didSignInPressed(_ sender: Any) {
        viewModel.signIn(user: .init(email: emailTextField.text, password: passwordTextField.text), onComplete: {[weak self] result in
            switch result {
            case .success:
                self?.navigateToSendMoney()
            case .failure(let error):
                self?.showError(error)
            }
        })
    }
}

private extension LoginViewController {
    func configureViews() {
        configureSendMoneyLabel()
        configureWelcomeLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureSignInButton()
        configureTermsConditionsLabel()
    }
    
    func configureSendMoneyLabel() {
        sendMoneyLabel.text = UIStrings.signInSendMoney.localized
        sendMoneyLabel.textColor = .primaryTextColor
        sendMoneyLabel.font = .title
    }
    
    func configureWelcomeLabel() {
        welcomeLabel.text = UIStrings.signInWelcome.localized
        welcomeLabel.textColor = .secondaryTextColor
        welcomeLabel.font = .subTitle
    }
    
    func configureTermsConditionsLabel() {
        termsConditionsLabel.text = UIStrings.signInTermsConditions.localized
        termsConditionsLabel.textColor = .secondaryTextColor
        termsConditionsLabel.font = .subTitle
    }
    
    func configureEmailTextField() {
        emailTextField.placeholder = UIStrings.signInEmailPlaceHolder.localized
    }
    
    func configurePasswordTextField() {
        passwordTextField.placeholder = UIStrings.signInPasswordPlaceHolder.localized
        passwordTextField.isSecureTextEntry = true
    }
    
    func configureSignInButton() {
        signInButton.setTitle(UIStrings.signInActionTitle.localized, for: .normal)
        signInButton.titleLabel?.font = .title
        signInButton.setTitleColor(.navigationTintColor, for: .normal)
        signInButton.backgroundColor = .navigationBarColor
        signInButton.addCorner()
    }
}

private extension LoginViewController {
    func navigateToSendMoney() {
        let viewModel = SendMoneyViewModel()
        let viewController = SendMoneyViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
