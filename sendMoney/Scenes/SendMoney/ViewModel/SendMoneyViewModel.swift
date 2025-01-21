//
//  SendMoneyViewModel.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 20/01/2025.
//

import Foundation

class SendMoneyViewModel {
    private var jsonModelFile: JSONResources
    private var coreDataManager: CoreDataProcotol?
    private var isServiceProviderSelected: Bool {
        return selectedService != nil && selectedProvider != nil
    }
    var selectedProvider: Provider?
    var selectedService: Service? {
        didSet {
            selectedProvider = nil
        }
    }
    var jsonResponse: SendMoneyModel?

    init(jsonModelFile: JSONResources = .sendMoney, coreDataManager: CoreDataProcotol = CoreDataManager()) {
        self.jsonModelFile = jsonModelFile
        self.coreDataManager = coreDataManager
    }
    
    func retrieveData(onComplete: ((Result<Bool, CustomError>)-> Void)) {
        guard let jsonData = jsonModelFile.loadFile(type: SendMoneyModel.self) else {
            onComplete(.failure(.custom(UIStrings.generalErrorMessage.localized)))
            return
        }
        jsonResponse = jsonData
        onComplete(.success(true))
    }
    
    func shouldEnableAction() -> Bool {
        return isServiceProviderSelected
    }
    
    func canSaveRequest(values: [String?]) -> Bool {
        guard isServiceProviderSelected else { return false }
        for (index, input) in (selectedProvider?.requiredFields ?? []).enumerated() {
            guard isValueValid(text: values[index], regex: input.validation) else { return false }
        }
        return true
    }
    
    func isValueValid(text: String?, regex: String?)-> Bool {
        guard let text = text, text.isEmpty == false else {
            return false
        }
        guard let regex = regex, regex.isEmpty == false else {
            return true
        }
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
    func saveRequest(values: [String?], onComplete:((Bool)-> Void)) {
        var dictionary = [RequestConstant.service.rawValue: selectedService?.label?.localized, RequestConstant.providerName.rawValue: selectedProvider?.name, RequestConstant.providerId.rawValue: selectedProvider?.id]
        for (index, input) in (selectedProvider?.requiredFields ?? []).enumerated() {
            dictionary[input.name ?? ""] = values[index]
        }
        let requestId = UUID()
        let context = coreDataManager?.fetchContext() ?? .init(concurrencyType: .mainQueueConcurrencyType)
        let entity = MoneyRequest(context: context)
        entity.id = requestId
        entity.details = convertDictionaryToJsonData(values: dictionary)
        coreDataManager?.saveData(context: context, onComplete: onComplete)
    }
}

private extension SendMoneyViewModel {
    func convertDictionaryToJsonData(values: [String: String?]) -> Data? {
        let jsonData = try? JSONSerialization.data(withJSONObject: values, options: .prettyPrinted)
        return jsonData
    }
}
