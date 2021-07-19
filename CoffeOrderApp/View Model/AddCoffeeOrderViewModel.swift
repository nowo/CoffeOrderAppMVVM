//
//  AddCoffeeOrderViewModel.swift
//  CoffeOrderApp
//
//  Created by ecinar on 19.07.2021.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var total: Int?
    
    var selectedType: String?
    var selectedSize: String?
    
    var coffeeName: [String] {
        return CoffeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var size: [String] {
        return CoffeSize.allCases.map { $0.rawValue.capitalized }
    }
    
}
