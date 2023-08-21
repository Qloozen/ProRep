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
    // MARK: PUBLIC
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var showRegistrationForm: Bool = false
    
    @Published var firstname: String = ""
    @Published var lastname: String = ""
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
    public func signInWithGoogle() async {
        do {
            let (credential, firstname, lastname, email) = try await SignInWithGoogle.sharedInstance.signIn()
            self.email = email
            self.firstname = firstname
            self.lastname = lastname
            await self.signInToFirebase(credential: credential)
        } catch {
            self.showError.toggle()
            return
        }
    }
    
    public func signInWithEmail() async {
        self.isLoading = true
        do {
            if let user = try await SignInWithEmail.sharedInstance.signIn(email: loginEmail, password: loginPassword) {
                AuthService.sharedInstance.storeUserdata(id: user.id, name: user.first_name)
            }
            self.isLoading = false
        } catch {
            self.showError.toggle()
            self.isLoading = false
        }
    }
    
    // MARK: PRIVATE
    private func signInToFirebase(credential: AuthCredential) async {
        do {
            if let user = try await AuthService.sharedInstance.signInToFirebase(credential: credential) {
                AuthService.sharedInstance.storeUserdata(id: user.id, name: user.first_name)
            } else {
                self.showRegistrationForm.toggle()
            }
        } catch {
            self.showError.toggle()
        }
        
    }
}
