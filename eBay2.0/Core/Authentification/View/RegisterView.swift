//
//  RegisterView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isShowingAuthentificationForm: Bool
    @State private var showAlert = false
    @State private var error = ""
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Let's create your account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical)
            
            VStack(spacing: 20) {
                TextField("Email", text: $viewModel.email)
                    .modifier(TextFieldCustom())
                    .autocapitalization(.none)
                
                TextField("Fullname", text: $viewModel.fullname)
                    .modifier(TextFieldCustom())
                
                SecureField(" Password", text: $viewModel.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                
                Button {
                    print("forgot passwotd")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    if viewModel.isFormValid {
                        Task{
                            do {
                                try await viewModel.registerUser()
                                isShowingAuthentificationForm.toggle()
                            } catch {
                                self.error = error.localizedDescription
                                self.showAlert = true
                            }
                        }
                    } else {
                        self.error = "Fill all required fields for registration."
                        showAlert = true
                    }
                    
                } label: {
                    Text("Register")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(12)
                        .foregroundColor(.white)
                        .frame(width: 360)
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("Have and account?")
                        Text("Sing In")
                            .fontWeight(.semibold)
                    }
                }
            }

        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isShowingAuthentificationForm = false
                } label: {
                    Image(systemName: "x.circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(.red)
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isShowingAuthentificationForm: .constant(true))
    }
}
