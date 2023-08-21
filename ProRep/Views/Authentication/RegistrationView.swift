//
//  RegistrationView.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistationViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Image("logo_large_transparent")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
            
            
            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 20) {
                UnderlineTextField(icon: "at", prompt: viewModel.emailPrompt) {
                    TextField("email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .onChange(of: viewModel.email) { newValue in
                            viewModel.emailPrompt = Validate.email(newValue)
                        }
                        
                }
    
                PasswordField(passwordInput: $viewModel.password, prompt: viewModel.passwordPrompt)
                    .onChange(of: viewModel.password) { newValue in
                        viewModel.passwordPrompt = Validate.password(newValue)
                    }
                
                PasswordField(passwordInput: $viewModel.passwordConfirm, prompt: viewModel.passwordConfirmPrompt)
                    .onChange(of: viewModel.passwordConfirm) { newValue in
                        viewModel.passwordConfirmPrompt = Validate.confirmPassword(viewModel.password, newValue)
                    }
            }
            
            StyledButton(title: "Register", isLoading: viewModel.isLoading, disabled: !viewModel.isValid) {
                print("Register Button")
                Task { await viewModel.registerWithEmail()}
            }
            
            Spacer()

        }
        .fullScreenCover(isPresented: $viewModel.showRegistrationForm, content: {
            RegistrationForum(viewModel: RegistrationForumViewModel(
                firstname: "",
                lastname: "",
                email: viewModel.email)
            )
        })
        .padding(25)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
