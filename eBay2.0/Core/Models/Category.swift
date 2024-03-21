//
//  Category.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import Foundation
import SwiftUI

enum ProductCategory: Codable {
    case AutomobilesAndMotorcycles
    case Books
    case CellPhonesAndAccessories
    case ComputersAndITAccessories
    case HandWatches
    case Jewellery
    case Medicine
    case Furniture
    case MensClothingAndAccessory
    case TablewareAndKitchenware
    case VideoGamesAndConsoles
    case WomensClothingAndAccessory
}

struct Category: Hashable {
    let title: String
    let imagePath: String
    let color: Color
    let category: ProductCategory
}

extension Category {
    static let categories: [Category] = [Category(title: "Automobiles & Motorcycles", imagePath: "Automobiles & Motorcycles", color: .pink, category: .AutomobilesAndMotorcycles),
                                         Category(title: "Books", imagePath: "Books", color: .mint, category: .Books),
                                         Category(title: "Cell Phones & Accessories", imagePath: "Cell Phones & Accessories", color: .red, category: .CellPhonesAndAccessories),
                                         Category(title: "Computers & IT Accessories", imagePath: "Computers & IT Accessories", color: .yellow, category: .ComputersAndITAccessories),
                                         Category(title: "Hand Watches", imagePath: "Hand Watches", color: .cyan, category: .HandWatches),
                                         Category(title: "Jewellery", imagePath: "Jewellery", color: .brown, category: .Jewellery),
                                         Category(title: "Medicine", imagePath: "Medicine", color: .orange, category: .Medicine),
                                         Category(title: "Furniture", imagePath: "Furniture", color: .blue, category: .Furniture),
                                         Category(title: "Men's Clothing & Accessory", imagePath: "Men's Clothing & Accessory", color: .green, category: .MensClothingAndAccessory),
                                         Category(title: "Tableware & Kitchenware", imagePath: "Tableware & Kitchenware", color: .pink, category: .TablewareAndKitchenware),
                                         Category(title: "Video Games & Consoles", imagePath: "Video Games & Consoles", color: .mint, category: .VideoGamesAndConsoles),
                                         Category(title: "Women's Clothing & Accessory", imagePath: "Women's Clothing & Accessory", color: .red, category: .WomensClothingAndAccessory)]
}
