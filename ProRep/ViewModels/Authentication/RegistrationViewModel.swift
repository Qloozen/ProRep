//
//  RegistrationViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseAuth

@MainActor class RegistationViewModel: ObservableObject {
    // MARK: Properties
    @Published var showRegistrationForm: Bool = false

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    
    @Published var provider_UID: String = ""
    
    @Published var emailPrompt: String?
    @Published var passwordPrompt: String?
    @Published var passwordConfirmPrompt: String?
    
    @Published var isLoading: Bool = false
    
    public var isValid: Bool {
        Validate.email(email) == nil && Validate.password(password) == nil && Validate.confirmPassword(password, passwordConfirm) == nil
    }

    // MARK: Public functions
    public func registerWithEmail() {
        self.isLoading = true

        SignInWithEmail.sharedInstance.register(email: email, password: password) { [weak self] isError, isNewUser, provider_UID, user_id in
            guard !isError, let isNewUser, let provider_UID else {
                self?.isLoading = false
                return
            }
            
            self?.provider_UID = provider_UID
            
            if let user_id, !isNewUser {
                AuthService.sharedInstance.storeUserdata(user_id: user_id)
            } else {
                self?.showRegistrationForm.toggle()
            }
            self?.isLoading = false
        }
    }
}
