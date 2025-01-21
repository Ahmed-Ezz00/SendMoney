//
//  UIStrings.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

enum UIStrings: String {
    case signInTitle = "signIn.title"
    case signInSendMoney = "signIn.label.sendMoney"
    case signInWelcome = "signIn.label.welcome"
    case signInEmailPlaceHolder = "signIn.textField.email.placeHolder"
    case signInPasswordPlaceHolder = "signIn.textField.password.placeHolder"
    case signInActionTitle = "signIn.button.title"
    case signInTermsConditions = "signIn.label.termsConditions"
    case signInError = "signIn.error"
    case alertControllerActionOk = "alertController.action.ok"
    case generalErrorMessage = "general.error.message"
    case sendMoneyService = "sendMoney.label.service"
    case sendMoneyServicePlaceHolder = "sendMoney.textField.service.placeHolder"
    case sendMoneyProvider = "sendMoney.label.provider"
    case sendMoneyProviderPlaceHolder  = "sendMoney.textField.provider.placeHolder"
    case sendMoneyActionTitle = "sendMoney.button.title"
    case sendMoneyErrorRequired = "sendMoney.textField.error.required"
    case requestListTitle = "requestList.title"
    case requestListActionTitle = "requestList.button.title"
    case requestDetailsTitle = "requestDetails.title"
    
    var localized: String {
        return rawValue.localized
    }
}
