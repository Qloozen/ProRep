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
        VStack() {
            Image("logo_large_transparent")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                
                UnderlineTextField(textInput: $emailInput, hint: "email@example.com", icon: "at")
                    .keyboardType(.emailAddress)
                HStack {
                    Image(systemName: "key")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    SecureField("password", text: $passwordInput)
                        .textFieldStyle(UnderlineTextFieldStyle())
                }
            }
            
            Spacer()

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
                    Button("Register") {
                        print("go to register page")
                    }
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
