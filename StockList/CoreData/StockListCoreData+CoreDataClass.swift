import Foundation
import CoreData

@objc(StockListCoreData)
public class StockListCoreData: NSManagedObject {}

extension StockListCoreData {
    @NSManaged public var nameOfStock: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var nameOfCompany: String?
}

extension StockListCoreData : Identifiable {}
