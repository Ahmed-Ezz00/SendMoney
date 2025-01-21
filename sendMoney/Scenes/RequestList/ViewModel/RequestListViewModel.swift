//
//  RequestListViewModel.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 21/01/2025.
//

import Foundation

class RequestListViewModel {
    private var coreDataManger: CoreDataProcotol
    
    init(coreDataManger: CoreDataProcotol = CoreDataManager()) {
        self.coreDataManger = coreDataManger
    }
    
    func retrieveRequests(onComplete:(([RequestModel])-> Void)) {
        coreDataManger.fetchData(request: MoneyRequest.fetchRequest(), onComplete: {[weak self] data in
            let savedRequests = data as? [MoneyRequest]
            let requests = savedRequests?.map{RequestModel(id: $0.id?.uuidString, details: self?.convertDataToDictionary($0.details))} ?? []
            onComplete(requests)
        })
    }
}

private extension RequestListViewModel {
    func convertDataToDictionary(_ data: Data?) -> [String: String] {
        guard let data = data else { return [:] }
        do {
            let value = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            return value ?? [:]
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
}
