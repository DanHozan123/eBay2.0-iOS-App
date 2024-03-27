//
//  DoneButton.swift
//  eBay2.0
//
//  Created by Dan Hozan on 26.03.2024.
//

import SwiftUI

struct DoneButton: View {
    var body: some View {
        
        Text("Done")
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
    
}

struct DoneButton_Previews: PreviewProvider {
    static var previews: some View {
        DoneButton()
    }
}
