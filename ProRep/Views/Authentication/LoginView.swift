//
//  LoginView.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    
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
                UnderlineTextField(icon: "at") {
                    TextField("email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                }
                    
                PasswordField(passwordInput: $viewModel.password)
            }
            
            VStack(spacing: 15){
                StyledButton(title: "Login") {
                    print("Login button")
                    viewModel.signInWithEmail()
                }
 
                Text("OR")

                Button {
                    print("sign in with Apple")
                } label: {
                    HStack {
                        Image(systemName: "apple.logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        Text("Sign in with Apple")
                    }
                }
                .tint(Color(uiColor: .secondarySystemBackground))
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.primary)
                .cornerRadius(10)
                .fontWeight(.bold)
                .font(.system(size: 18))
                
                Text("OR")

                Button {
                    print("sign in with Google")
                    viewModel.signInWithGoogle()
                } label: {
                    HStack {
                        Image("google")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 24)
                        Text("Sign in with Google")
                    }
                }
                .tint(Color(uiColor: .secondarySystemBackground))
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.primary)
                .cornerRadius(10)
                .fontWeight(.bold)
                .font(.system(size: 18))
                                
                HStack(spacing: 0) {
                    Text("New to ProRep? ")
                    NavigationLink("Register") {
                        RegistrationView()
                    }
                    .foregroundColor(Color.themedGreen)
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.showRegistrationForm, content: {
            RegistrationForum(viewModel: viewModel)
        })
        .padding(25)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
