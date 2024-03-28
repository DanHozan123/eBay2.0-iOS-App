//
//  AddProduct.swift
//  eBay2.0
//
//  Created by Dan Hozan on 26.03.2024.
//

import SwiftUI

struct AddProductView: View {
    
    var category: Category
    private let dimension = (UIScreen.main.bounds.width / 2)
   
    @Environment(\.presentationMode) var presentationMode
    @State private var imagePickerPresented = false
    @State private var showAlert = false
    
    @StateObject var viewModel = AddProductViewModel()
    
    var body: some View {
        VStack {
            
            VStack {
                if let image = viewModel.productImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: dimension, height: dimension)
                        .cornerRadius(10)
                        .padding(.bottom)
                } else {
                    Image(systemName: "photo.stack")
                        .resizable()
                        .scaledToFit()
                        .frame(width: dimension, height: dimension)
                        .cornerRadius(10)
                        .padding(.bottom)
                }
            }
            .onTapGesture {
                imagePickerPresented.toggle()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                TextField("Title", text: $viewModel.title)
                    .modifier(TextFieldCustom())
                
                HStack() {
                    TextField("Condition", text: $viewModel.condition)
                        .modifier(TextFieldCustom())
                    
                    TextField("Price", text: $viewModel.price)
                        .modifier(TextFieldCustom())
                }
                
                Text(" Product Features:")
                    .font(.subheadline)
                
                TextEditor(text: $viewModel.features)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGray6))
                    .frame(maxHeight: 250)
                    .cornerRadius(10)

            }
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Add Product")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }, label: { Image(systemName: "chevron.left") })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        if viewModel.formValidation {
                            await viewModel.uploadProduct(productCategory: category.category)
                            presentationMode.wrappedValue.dismiss()
                        }
                        else {
                            showAlert.toggle()
                        }
                    }
                    
                } label: {
                    DoneButton()
                }
            }
        }
        .tint(.black)
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text("Fill all required fields for registration."), dismissButton: .default(Text("OK")))
        })
    }
}

struct AddProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(category: Category.hardcodedProductCategories[2])
    }
}
