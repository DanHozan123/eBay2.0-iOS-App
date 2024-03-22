//
//  TextField.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import SwiftUI




struct TextFieldCustom: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}


