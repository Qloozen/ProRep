//
//  RegistrationView.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var confirmPasswordInput: String = ""

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
                UnderlineTextField(textInput: $emailInput, hint: "email@example.com", icon: "at")
                    .keyboardType(.emailAddress)
                
                PasswordField(passwordInput: $passwordInput)
                
                PasswordField(passwordInput: $confirmPasswordInput)
            }
            
            StyledButton(title: "Register") {
                print("Register Button")
            }
            
            Spacer()

        }
        .padding(25)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
