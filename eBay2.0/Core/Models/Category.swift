//
//  Category.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import Foundation
import SwiftUI

import Foundation
import SwiftUI

enum ProductCategory: String, Codable {
    case automobilesAndMotorcycles = "Automobiles & Motorcycles"
    case books = "Books"
    case cellPhonesAndAccessories = "Cell Phones & Accessories"
    case computersAndITAccessories = "Computers & IT Accessories"
    case handWatches = "Hand Watches"
    case jewellery = "Jewellery"
    case medicine = "Medicine"
    case furniture = "Furniture"
    case mensClothingAndAccessory = "Men's Clothing & Accessory"
    case tablewareAndKitchenware = "Tableware & Kitchenware"
    case videoGamesAndConsoles = "Video Games & Consoles"
    case womensClothingAndAccessory = "Women's Clothing & Accessory"
}

struct Category: Hashable {
    let title: String
    let imagePath: String
    let color: Color
    let category: ProductCategory
}

extension Category {
    static let hardcodedProductCategories: [Category] = [
        
        Category(title: ProductCategory.automobilesAndMotorcycles.rawValue,
                 imagePath: ProductCategory.automobilesAndMotorcycles.rawValue,
                 color: .pink,
                 category: .automobilesAndMotorcycles),
        
        Category(title: ProductCategory.books.rawValue,
                 imagePath: ProductCategory.books.rawValue,
                 color: .mint,
                 category: .books),
        
        Category(title: ProductCategory.cellPhonesAndAccessories.rawValue,
                 imagePath: ProductCategory.cellPhonesAndAccessories.rawValue,
                 color: .red, category: .cellPhonesAndAccessories),
        
        Category(title: ProductCategory.computersAndITAccessories.rawValue,
                 imagePath: ProductCategory.computersAndITAccessories.rawValue,
                 color: .yellow,
                 category: .computersAndITAccessories),
        
        Category(title: ProductCategory.handWatches.rawValue,
                 imagePath: ProductCategory.handWatches.rawValue,
                 color: .cyan,
                 category: .handWatches),
        
        Category(title: ProductCategory.jewellery.rawValue,
                 imagePath: ProductCategory.jewellery.rawValue,
                 color: .brown,
                 category: .jewellery),
        
        Category(title: ProductCategory.medicine.rawValue,
                 imagePath: ProductCategory.medicine.rawValue,
                 color: .orange,
                 category: .medicine),
        
        Category(title: ProductCategory.furniture.rawValue,
                 imagePath: ProductCategory.furniture.rawValue,
                 color: .blue,
                 category: .furniture),
        
        Category(title: ProductCategory.mensClothingAndAccessory.rawValue,
                 imagePath: ProductCategory.mensClothingAndAccessory.rawValue,
                 color: .green,
                 category: .mensClothingAndAccessory),
        
        Category(title: ProductCategory.tablewareAndKitchenware.rawValue,
                 imagePath: ProductCategory.tablewareAndKitchenware.rawValue,
                 color: .pink,
                 category: .tablewareAndKitchenware),
        
        Category(title: ProductCategory.videoGamesAndConsoles.rawValue,
                 imagePath: ProductCategory.videoGamesAndConsoles.rawValue,
                 color: .mint,
                 category: .videoGamesAndConsoles),
        
        Category(title: ProductCategory.womensClothingAndAccessory.rawValue,
                 imagePath: ProductCategory.womensClothingAndAccessory.rawValue,
                 color: .red,
                 category: .womensClothingAndAccessory)
    ]
}
