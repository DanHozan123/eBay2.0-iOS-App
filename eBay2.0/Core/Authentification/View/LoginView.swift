//
//  LoginView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isShowingAuthentificationForm: Bool
    @State private var showAlert = false
    @State private var error = ""
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                
                Image("eBay Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                
                TextField("Email", text: $viewModel.email)
                    .modifier(TextFieldCustom())
                    .autocapitalization(.none)
                
                SecureField(" Password", text: $viewModel.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                
                
                Button{
                    Task {
                        if viewModel.isFormValid {
                            do {
                                try await viewModel.login()
                                isShowingAuthentificationForm.toggle()
                            } catch {
                                self.error = error.localizedDescription
                                self.showAlert = true
                            }
                        } else {
                            self.error = "Fill all required fields to login."
                            showAlert = true
                        }
                    }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(12)
                        .foregroundColor(.white)
                        .frame(width: 360)
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                NavigationLink(destination: RegisterView(isShowingAuthentificationForm: $isShowingAuthentificationForm), label: {
                    HStack {
                        Text("Don't have and account?")
                        Text("Sing Up")
                            .fontWeight(.semibold)
                    }
                })
                
            }
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isShowingAuthentificationForm: .constant(true))
    }
}
