//
//  SearchView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct SearchView: View {
    
    var user: User?
    
    var body: some View {
        
        VStack{
            Text(user?.fullname ?? "Guest User")
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(user: User.MOCK_DATA)
    }
}
