//
//  CustomTextField.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 20/01/2025.
//

import UIKit

class CustomTextField: UIView {
    
    @IBOutlet private weak var textFieldContainerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    
    var onTextEndEditing: ((String?)->Void)?
    var onValueSelected: ((Int)->Void)?
    var maxLength: Int?
    var selectionData: [String]? {
        didSet {
            guard selectionData != nil else { return }
            addPickerView()
        }
    }
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.superview?.isHidden = title?.isEmpty ?? true
        }
    }
    var errorMessage: String? {
        didSet {
            errorLabel.text = errorMessage
            errorLabel.superview?.isHidden = title?.isEmpty ?? true
        }
    }
    var placeholder: String? {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: UIColor.secondaryTextColor])
        }
    }
    var text: String? {
        return textField.text
    }
    var image: UIImage? {
        didSet {
            imageView.image = image?.withRenderingMode(.alwaysOriginal).withTintColor(.secondaryTextColor)
            imageView.superview?.isHidden = image == nil
        }
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setText(_ text: String?) {
        textField.text = text
    }
}

private extension CustomTextField {
    func commonInit() {
        loadViewFromNib()
        configureTitleLabel()
        configureTextField()
        configureErrorLabel()
        configureimageView()
    }
    
    func configureimageView() {
        imageView.superview?.isHidden = true
    }
    
    func configureTitleLabel() {
        titleLabel.textColor = .primaryTextColor
        titleLabel.font = .title
        titleLabel.superview?.isHidden = true
    }
    
    func configureErrorLabel() {
        errorLabel.textColor = .errorTextColor
        errorLabel.font = .subTitle
        errorLabel.superview?.isHidden = true
    }
    
    func configureTextField() {
        textField.font = .subTitle
        textField.textColor = .primaryTextColor
        textFieldContainerView.backgroundColor = .whiteColor
        textFieldContainerView.addCorner(12)
        textField.textAlignment = LanguageManager.shared.isRTL() ? .right: .left
        textField.delegate = self
        textField.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
    }

    func addPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.inputView = pickerView
    }
    
    @objc
    func onTextChanged() {
        guard let maxLength = maxLength, maxLength > .zero, (self.text?.count ?? 0) > maxLength else { return }
        textField.deleteBackward()
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard errorMessage != nil else { return }
        errorMessage = nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onTextEndEditing?(textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return selectionData == nil
    }
}

extension CustomTextField: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectionData?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectionData?[row]
    }
}

extension CustomTextField: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = view as? UILabel ?? UILabel()
        label.font = .title
        label.textColor = .primaryTextColor
        label.text = selectionData?[row]
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = selectionData?[row]
        onValueSelected?(row)
        endEditing(true)
    }
}
