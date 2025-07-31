import UIKit

enum PageOfTable: String, CaseIterable {
    case stocks = "Stocks"
    case favourite = "Favourite"

    var tableCell: UITableViewCell {
        switch self {
        case .stocks:
            return StockTableViewCell()
        case .favourite:
            return StockTableViewCell()
        }
    }
//    var isActive: Bool {
//        switch self {
//        case .stocks: return true
//        case .favourite: return false
//        }
//    }
//    
//    var associatedTableView: UITableView {
//        let tableView = UITableView()
//        
//        switch self {
//        case .stocks:
//            tableView.register(StockTableViewCell.self)
//            tableView.tag = 0
//        case .favourite:
//            tableView.register(StockTableViewCell.self)
//            tableView.tag = 1
//        }
//            
//        return tableView
//    }
}
