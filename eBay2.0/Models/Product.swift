//
//  Product.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: String
    let ownerId: String
    let title: String
    let condition: String
    let price: Float
    let features: String
    let productImageLink: String
    let timestamp: Date
    let category: ProductCategory
    
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}


extension Product {
    static let MOCK_DATA: [Product] = [
        .init(id: UUID().uuidString,
              ownerId: "1",
              title: "I15 Pro Max 5G Factory Unlocked Smartphone 7.3 Dual Sim 8+256 Android 13 Phones",
              condition: "New",
              price: 99.99,
              features: "3D Face Recognition, 4K Video Recording, Camera, Color Screen, Email, Web, Email Access, Facial Recognition, Fast Charging, FM Radio, Front Camera, GPS, HDR Display, High Capacity Battery (5000 mAh or More), Music Player, Nano SIM, Rear Camera, Speakerphone, Stylus, Touch Screen, Wi-Fi Capable, Support OTG, Dual Sim",
              productImageLink: "I15 Pro Max",
              timestamp: Date(),
              category: .cellPhonesAndAccessories),
        
        .init(id: UUID().uuidString,
              ownerId: "1",
              title: "New i15 Pro Max 7.3 Android Smartphone 16GB+1TB 5G Global Unlocked Cell Phone",
              condition: "New",
              price: 159.99,
              features: "3D Face Recognition, 4K Video Recording, Camera, Color Screen, Email Access, Facial Recognition, Fast Charging, FM Radio, Front Camera, GPS, HDR Display, High Capacity Battery (5000 mAh or More), Music Player, Nano SIM, Rear Camera, Speakerphone, Stylus, Touch Screen, Wi-Fi Capable, Email, Web, Support OTG, Dual Sim",
              productImageLink: "New i15 Pro Max",
              timestamp: Date(),
              category: .cellPhonesAndAccessories),
        
        .init(id: UUID().uuidString,
              ownerId: "1",
              title: "6.8 Unlocked i14 Pro Max Android 10 Smartphone Dual Sim 4G Phone Mobile 4+ 64GB",
              condition: "New",
              price: 68.99,
              features: "Model No. i14 Pro Max, MTK6595, Standby Dual SIM (SIM + SIM + Memory Card), Screen 7 HD+ Display 1440x3040 , Speaker 1511 Box Speaker, Vibration Support, Colors White/Black/Gold/Blue, Memory 4GB RAM+64GB ROM, Multi Media MP3/MP4/3GP/FM Radio/Bluetooth, Camera 8MP+16MP, Multi Function Full screen, Face recognition, Dual SIM, Wifi, GPS, Gravity Sensor, Alarm ,Calendar ,Calculator ,Audio recorder ,Video recorder, WAPMMSGPR, Image viewer,E-Book,World clock,Tasks card rear flash IML rear cover, Languages Multi-language support, Others: Android 10.0 Syste, Battery 4500Mah Lithium-ion battery",
              productImageLink: "6.8 Unlocked i14 Pro Max",
              timestamp: Date(),
              category: .cellPhonesAndAccessories),
        
        .init(id: UUID().uuidString,
              ownerId: "1",
              title: "Apple Watch Series 9 - GPS + GSM Cellular 41mm Smart Watch - Excellent",
              condition: "New",
              price: 299.99,
              features: "GPS, Cellular, GPS + Cellular, LTE and UMTS8, Wi-Fi 4 (802.11n), Bluetooth 5.3, Second-generation Ultra Wideband chip11, Apple Pay, GymKit, Up to 18 hours normal use, Up to 36 hours in Low Power Mode9, Always-On Retina display Up to 2000 nits, S9 SiP, Double tap gesture, Faster on-device Siri with health data access, Precision Finding for iPhone2, Blood Oxygen app3, ECG app4, High and low heart rate notifications4, Irregular rhythm notifications5, Low cardio notifications, Emergency SOS8, International emergency calling9, Fall Detection and Crash Detection8, Water resistant11, Swimproof, Supports Family Setup (GPS + Cellular models)1, Available cellular connectivity13, Up to 36 hours in Low Power Mode16, Fast charging17",
              productImageLink: "Apple Watch Series 9",
              timestamp: Date(),
              category: .handWatches)
    ]
}
