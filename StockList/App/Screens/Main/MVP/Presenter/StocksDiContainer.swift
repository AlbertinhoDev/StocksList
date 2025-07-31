import UIKit

final class StocksDiContainer: StocksDiContainerable {
    var stocksApiService: StocksApiServicable
    
    init(stocksApiService: StocksApiServicable = StocksApiService()) {
        self.stocksApiService = stocksApiServiceApiService
    }
}
