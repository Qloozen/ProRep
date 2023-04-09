//
//  LoginView.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Image("logo_large_transparent")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
            
            Spacer()
            
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 20) {
                UnderlineTextField(textInput: $emailInput, hint: "email@example.com", icon: "at")
                    .keyboardType(.emailAddress)
                PasswordField(passwordInput: $passwordInput)
            }
            
            VStack(spacing: 15){
                StyledButton(title: "Login") {
                    print("Login button")
                }
 
                Text("OR")

                StyledButton(title: "Apple") {
                    print("Apple button")
                }
                Text("OR")

                StyledButton(title: "Google") {
                    print("Google button")
                }
                                
                HStack(spacing: 0) {
                    Text("New to ProRep? ")
                    NavigationLink("Register") {
                        RegistrationView()
                    }
                    .foregroundColor(Color.themedGreen)
                }
            }
        }
        .padding(25)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
