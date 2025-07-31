//
//  Entity+CoreDataProperties.swift
//  StockList
//
//  Created by Albert on 22.07.2025.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var nameOfStock: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var nameOfCompany: String?

}

extension Entity : Identifiable {

}
