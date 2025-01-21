//
//  SendMoneyModel.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 20/01/2025.
//

struct SendMoneyModel: Codable {
    let title: LanguageLabel?
    let services: [Service]?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case services = "services"
    }
}

struct Service: Codable {
    let label: LanguageLabel?
    let name: String?
    let providers: [Provider]?

    enum CodingKeys: String, CodingKey {
        case label = "label"
        case name = "name"
        case providers = "providers"
    }
}

struct Provider: Codable {
    let name: String?
    let id: String?
    let requiredFields: [RequiredField]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case requiredFields = "required_fields"
    }
}

struct RequiredField: Codable {
    let label: LanguageLabel?
    let name: String?
    let type: InputType?
    let validation: String?
    let maxLength: String?
    let options: [Option]?
    var validationErroMessage: LanguageLabel?
    var placeholder: LanguageLabel?

    enum CodingKeys: String, CodingKey {
        case label = "label"
        case name = "name"
        case placeholder = "placeholder"
        case type = "type"
        case validation = "validation"
        case maxLength = "max_length"
        case validationErroMessage = "validation_error_message"
        case options = "options"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(LanguageLabel.self, forKey: .label)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        type = try values.decodeIfPresent(InputType.self, forKey: .type)
        validation = try values.decodeIfPresent(String.self, forKey: .validation)
        options = try values.decodeIfPresent([Option].self, forKey: .options)
        maxLength = try? values.decodeIfPresent(Int.self, forKey: .maxLength)?.description ?? values.decodeIfPresent(String.self, forKey: .maxLength)
        validationErroMessage = getLocalizedValue(values: values, key: .validationErroMessage)
        placeholder = getLocalizedValue(values: values, key: .placeholder)
    }
    
    private func getLocalizedValue(values: KeyedDecodingContainer<CodingKeys>, key: CodingKeys) -> LanguageLabel? {
        guard let valueDic = try? values.decodeIfPresent(LanguageLabel.self, forKey: key) else {
            let value = try? values.decodeIfPresent(String.self, forKey: key)
            return LanguageLabel(en: value, ar: value)
        }
        return valueDic
    }
}

struct LanguageLabel: Codable {
    let en: String?
    let ar: String?
    var localized: String? {
        let arabicValue = ar?.isEmpty == false ? ar: en
        return LanguageManager.shared.getCurrentLanguage() == .arabic ? arabicValue: en
    }
    enum CodingKeys: String, CodingKey {
        case en = "en"
        case ar = "ar"
    }
}

struct Option: Codable {
    let label: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case label
        case name
    }
}

enum InputType: String, Codable {
    case text
    case number
    case option
    case msisdn
}
