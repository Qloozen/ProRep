//
//  LoginViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor class LoginViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var showRegistrationForm: Bool = false
    
    @Published var name: String = ""
    @Published var email: String = "" // email from providers
    @Published var provider_UID: String = ""
    
    @Published var loginEmail: String = ""
    @Published var loginPassword: String = ""
    
    @Published var emailPrompt: String?
    @Published var passwordPrompt: String?
    
    public var isValid: Bool {
        Validate.email(loginEmail) == nil && Validate.password(loginPassword) == nil
    }
    
    // MARK: Public functions
    public func signInWithGoogle() {
        SignInWithGoogle.sharedInstance.signIn { credential, name, email in
            guard let credential, let name, let email else {
                self.showError.toggle()
                return
            }
            
            self.name = name
            self.email = email
            self.signInToFirebase(credential: credential)
        }
    }
    
    public func signInWithEmail() {
        self.isLoading = true
        SignInWithEmail.sharedInstance.signIn(email: loginEmail, password: loginPassword) { user_id in
            guard let user_id else {
                self.isLoading = false
                return
            }
            AuthService.sharedInstance.storeUserdata(user_id: user_id)
            self.isLoading = false
        }
    }
    
    // MARK: Private
    private func signInToFirebase(credential: AuthCredential) {
        AuthService.sharedInstance.signInToFirebase(credential: credential) { [weak self] isError, isNewUser, provider_UID, user_id in
            guard !isError, let isNewUser, let provider_UID else {
                self?.showError.toggle()
                return
            }
            
            self?.provider_UID = provider_UID
            
            if let user_id, !isNewUser {
                print("Existing user")
                AuthService.sharedInstance.storeUserdata(user_id: user_id)
            } else {
                self?.showRegistrationForm.toggle()
            }
        }
    }
}
