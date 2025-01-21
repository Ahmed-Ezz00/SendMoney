//
//  SendMoneyViewController.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 20/01/2025.
//

import UIKit

class SendMoneyViewController: BaseViewController {

    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var requiredFieldStackView: UIStackView!
    @IBOutlet private weak var providerTextField: CustomTextField!
    @IBOutlet private weak var serviceTextField: CustomTextField!
    
    private let viewModel: SendMoneyViewModel
    
    var isButtonEnable: Bool = false {
        didSet {
            sendButton.isEnabled = isButtonEnable
            sendButton.alpha = isButtonEnable ? 1 : 0.5
        }
    }
    
    init(viewModel: SendMoneyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        retrieveData()
    }
    
    @IBAction private func didSendPressed(_ sender: Any) {
        view.endEditing(true)
        let values = requiredFieldStackView.arrangedSubviews.map{($0 as? CustomTextField)?.text}
        guard viewModel.canSaveRequest(values: values) else {
            return refreshInputs()
        }
        viewModel.saveRequest(values: values) {[weak self] isRequestSaved in
            guard isRequestSaved else {
                self?.showError(.custom(UIStrings.generalErrorMessage.localized))
                return
            }
            self?.navigateToRequestList()
        }
    }
}

private extension SendMoneyViewController {
    
    func configureViews() {
        configureServiceTextField()
        configureProviderTextField()
        configureSendButton()
    }
    
    func configureServiceTextField() {
        serviceTextField.title = UIStrings.sendMoneyService.localized
        serviceTextField.placeholder = UIStrings.sendMoneyServicePlaceHolder.localized
        serviceTextField.image = UIImage(named: UIImageConstant.dropDown.rawValue)
        serviceTextField.onValueSelected = { [weak self] index in
            self?.didServiceSelected(index: index)
        }
    }
    
    func configureProviderTextField() {
        providerTextField.title = UIStrings.sendMoneyProvider.localized
        providerTextField.placeholder = UIStrings.sendMoneyProviderPlaceHolder.localized
        providerTextField.image = UIImage(named: UIImageConstant.dropDown.rawValue)
        providerTextField.onValueSelected = { [weak self] index in
            self?.didProviderSelected(index: index)
        }
        providerTextField.isHidden = true
    }
    
    func configureSendButton() {
        sendButton.setTitle(UIStrings.sendMoneyActionTitle.localized, for: .normal)
        sendButton.titleLabel?.font = .title
        sendButton.setTitleColor(.navigationTintColor, for: .normal)
        sendButton.backgroundColor = .actionColor
        sendButton.addCorner(16)
        isButtonEnable = false
    }
    
    func retrieveData() {
        viewModel.retrieveData(onComplete: {[weak self] result in
            switch result {
            case .success:
                self?.reloadData()
            case .failure(let error):
                self?.showError(error)
            }
        })
    }
    
    func reloadData() {
        title = viewModel.jsonResponse?.title?.localized
        serviceTextField.selectionData = viewModel.jsonResponse?.services?.map {$0.label?.localized ?? ""}
    }
    
    func didServiceSelected(index: Int) {
        providerTextField.setText(nil)
        resetRequiredFields()
        viewModel.selectedService = viewModel.jsonResponse?.services?[index]
        providerTextField.isHidden = false
        providerTextField.selectionData =  viewModel.selectedService?.providers?.map{$0.name ?? ""}
        isButtonEnable = viewModel.shouldEnableAction()
    }
    
    func didProviderSelected(index: Int) {
        viewModel.selectedProvider =  viewModel.selectedService?.providers?[index]
        isButtonEnable = viewModel.shouldEnableAction()
        resetRequiredFields()
        reloadRequiredInputs()
    }
    
    func resetRequiredFields() {
        requiredFieldStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
    }
    
    func reloadRequiredInputs() {
        for input in viewModel.selectedProvider?.requiredFields ?? [] {
            let inputTextField = CustomTextField()
            inputTextField.title = input.label?.localized
            inputTextField.placeholder = input.placeholder?.localized
            inputTextField.keyboardType = input.type == .number || input.type == .msisdn ? .asciiCapableNumberPad: .default
            inputTextField.image = input.type == .option ? UIImage(named: UIImageConstant.dropDown.rawValue): nil
            inputTextField.selectionData = input.options?.map{$0.label ?? ""}
            inputTextField.maxLength = Int(input.maxLength ?? "0")
            requiredFieldStackView.addArrangedSubview(inputTextField)
        }
    }
    
    func refreshInputs() {
        for (index,input) in requiredFieldStackView.arrangedSubviews.enumerated() {
            guard let inputField = input as? CustomTextField else { return }
            let requiredField = viewModel.selectedProvider?.requiredFields?[index]
            var errorMessage = requiredField?.validationErroMessage?.localized ?? ""
            errorMessage = errorMessage.isEmpty == false ? errorMessage: String(format: UIStrings.sendMoneyErrorRequired.localized, requiredField?.label?.localized ?? "")
            inputField.errorMessage = viewModel.isValueValid(text: inputField.text, regex: requiredField?.validation) ? nil: errorMessage
        }
    }
    
    func navigateToRequestList() {
        let viewModel = RequestListViewModel()
        let viewController = RequestListViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
