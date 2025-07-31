import UIKit

//MARK: - StockCellModel
struct StockCellModel {
    
    //MARK: - Properties
    var icon: UIImage
    var nameOfTicker: String
    var nameOfCompName: String
    var favourite: Bool
    var curPrice: Double
    var dayDelta: Double
    var dayDeltaPercent: Double
}

//MARK: - StocksCoreDataModel
struct StocksCoreDataModel {
    
    //MARK: - Properties
    var nameOfStock: String
    var favourite: Bool
    var nameOfCompany: String
}


