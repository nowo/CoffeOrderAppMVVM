//
//  Order.swift
//  CoffeOrderApp
//
//  Created by ecinar on 19.07.2021.
//

import Foundation

enum CoffeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let total: Int
    let coffeeName: CoffeType
    let size: CoffeSize
}

extension Order {
    
    static var all: Resource<[Order]> = {
        
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        return Resource<[Order]>(url: url)
        
    }()
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        
        let order = Order(vm)
        
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
        
    }
    
}

extension Order {
    init?(_ vm: AddCoffeeOrderViewModel) {
     
        guard let name = vm.name,
        let totalOrder = vm.total,
        let selectedType = CoffeType(rawValue: vm.selectedType!.lowercased()),
        let selectedSize = CoffeSize(rawValue: vm.selectedSize!.lowercased()) else {
        return nil
    }
        self.name = name
        self.total = totalOrder
        self.coffeeName = selectedType
        self.size = selectedSize
        
    }
}

