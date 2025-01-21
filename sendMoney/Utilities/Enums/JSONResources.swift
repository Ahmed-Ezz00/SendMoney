//
//  JSONResources.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 20/01/2025.
//

import UIKit

enum JSONResources: String {
    case sendMoney = "SendModelJson"
    case none
}

extension JSONResources {
    func loadFile<T: Codable>(type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: rawValue, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let jsonData = try? JSONDecoder().decode(type, from: data) else { return nil }
        return jsonData
    }
}
