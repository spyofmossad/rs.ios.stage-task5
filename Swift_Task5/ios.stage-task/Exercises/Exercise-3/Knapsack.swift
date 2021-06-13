import Foundation

enum SupplyType {
    case food
    case drink
    case none
}

struct SomeSupply: Equatable, Hashable {
    var type: SupplyType
    var weight: Int
    var value: Int
    
    static func ==(lhs: SomeSupply, rhs: SomeSupply) -> Bool {
        return lhs.value == rhs.value && lhs.weight == rhs.weight
    }
}

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        let foodSupplies = foods.map { SomeSupply(type: .food, weight: $0.weight, value: $0.value) }
        let drinkSupplies = drinks.map { SomeSupply(type: .drink, weight: $0.weight, value: $0.value) }
        let allCombinations = (foodSupplies + drinkSupplies).combinationsWithoutRepetition
        
        let filteredCombinations = allCombinations.filter {
            $0.reduce(0) { $0 + $1.weight } <= maxWeight &&
                !(Set($0).intersection(Set(foodSupplies))).isEmpty &&
                !(Set($0).intersection(Set(drinkSupplies))).isEmpty
        }
        
        let ranges = filteredCombinations.map { combo -> Int in
            let maxFoodRange = combo
                .filter { supply in supply.type == .food}
                .reduce(0) { $0 + $1.value }
            
            let maxDrinkRange = combo
                .filter { supply in supply.type == .drink}
                .reduce(0) { $0 + $1.value }
            
            return min(maxFoodRange, maxDrinkRange)
        }
        
        return ranges.sorted(by: >).first ?? 0
    }
}


extension Array {
    var combinationsWithoutRepetition: [[Element]] {
        guard !isEmpty else { return [[]] }
        return Array(self[1...]).combinationsWithoutRepetition.flatMap { [$0, [self[0]] + $0] }
    }
}
