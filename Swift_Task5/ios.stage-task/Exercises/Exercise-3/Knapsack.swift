import Foundation

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
        if (maxWeight > 0 && maxWeight > 2500)  {
            return 0
        }
        
        let foodsKnapsack = getKnapsack(for: foods)
        let drinksKnapsack = getKnapsack(for: drinks)
        var maxDistance = 0
        for i in 0...maxWeight {
            maxDistance = max(maxDistance, min(foodsKnapsack[foods.count][i], drinksKnapsack[drinks.count][maxWeight-i]))
        }
        return maxDistance
    }
    
    func getKnapsack(for array: [Supply]) -> [[Int]] {
        var knapsack: [[Int]] = Array(repeating: Array(repeating: 0, count: maxWeight+1), count: array.count+1)
        for i in 0 ... array.count {
            for j in 0 ... maxWeight {
                if (i != 0 && j != 0) {
                    if (array[i - 1].weight > j){
                        knapsack[i][j] = knapsack[i - 1][j]
                    } else {
                        knapsack[i][j] = max(knapsack[i - 1][j],
                                          (array[i - 1].value + knapsack[i - 1][j - array[i - 1].weight]))
                    }
                }
            }
        }
        return knapsack
    }
}
