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
                UnderlineTextField(icon: "at") {
                    TextField("email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                }
    
                PasswordField(passwordInput: $viewModel.password)
                
                PasswordField(passwordInput: $viewModel.passwordConfirm)
            }
            
            StyledButton(title: "Register") {
                print("Register Button")
                viewModel.registerWithEmail()
            }
            
            Spacer()

        }
        .fullScreenCover(isPresented: $viewModel.showRegistrationForm, content: {
            RegistrationForum(viewModel: RegistrationForumViewModel(
                name: "",
                email: viewModel.email,
                provider_UID: viewModel.provider_UID)
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
