//
//  RegistrationViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseAuth

@MainActor class RegistationViewModel: ObservableObject {
    // MARK: PUBLIC
    @Published var showRegistrationForm: Bool = false

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
        
    @Published var emailPrompt: String?
    @Published var passwordPrompt: String?
    @Published var passwordConfirmPrompt: String?
    
    @Published var isLoading: Bool = false
    
    public var isValid: Bool {
        Validate.email(email) == nil && Validate.password(password) == nil && Validate.confirmPassword(password, passwordConfirm) == nil
    }

    public func registerWithEmail() async {
        self.isLoading = true
        
        do {
            if let user = try await SignInWithEmail.sharedInstance.register(email: email, password: password) {
                AuthService.sharedInstance.storeUserdata(id: user.id, name: user.first_name)
            } else {
                self.isLoading = false
                self.showRegistrationForm.toggle()
            }
        } catch {
            self.isLoading = false
            //handle error
        }
    }
}
