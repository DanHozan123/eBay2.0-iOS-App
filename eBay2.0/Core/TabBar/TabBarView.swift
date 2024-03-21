//
//  ContentView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedIndex = 0

    
    var body: some View {
        
        TabView(selection: $selectedIndex) {
             
             HomeView()
               .tabItem {
                 Image(systemName: "house")
               }
               .tag(0)

             SearchView()
               .tabItem {
                 Image(systemName: "magnifyingglass")
               }
               .tag(1)
            
            FavoritesView()
              .tabItem {
                Image(systemName: "heart")
              }
              .tag(2)

            CartView()
              .tabItem {
                Image(systemName: "cart")
              }
              .tag(3)
            
            ProfileView()
              .tabItem {
                Image(systemName: "person")
              }
              .tag(4)
        
           }
           .accentColor(.black)
        
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
