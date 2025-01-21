//
//  MoneyRequest+CoreDataProperties.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 21/01/2025.
//
//

import Foundation
import CoreData


extension MoneyRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoneyRequest> {
        return NSFetchRequest<MoneyRequest>(entityName: "MoneyRequest")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var details: Data?

}

extension MoneyRequest : Identifiable {

}
