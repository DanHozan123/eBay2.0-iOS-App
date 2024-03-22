//
//  HomeView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct HomeView: View {
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5)
    ]
    
    private let dimension = (UIScreen.main.bounds.width / 2)
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 5) {
                    ForEach(Category.hardcodedProductCategories, id: \.self) { category in
                        NavigationLink(destination: ProductsView(category: category), label: {
                            VStack {
                                Image(category.imagePath)
                                    .resizable()
                                
                                Text(category.title)
                                    .foregroundColor(.black)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .frame(height: dimension)
                            .background(category.color)
                            .cornerRadius(10)
                            
                        })
                    }
                }
            }
            .padding(5)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
