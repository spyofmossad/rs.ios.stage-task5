import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        
        var maxPrice = 0
        var profit = 0
        var bottomIndex = 0
        
        if prices.count == 1 { return profit }
        
        for (index, price) in prices.enumerated() {
            if price >= maxPrice {
                maxPrice = price
                
                if index < prices.count - 1 {
                    continue
                }
            }
                        
            for n in bottomIndex...index - 1 {
                profit += maxPrice - prices[n]
            }
            bottomIndex = index
            maxPrice = 0
        }
        
        return profit
    }
}
