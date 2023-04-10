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
    
    // MARK: Public functions
    public func registerWithEmail() {
        SignInWithEmail.sharedInstance.register(email: email, password: password) { [weak self] isError, isNewUser, provider_UID, user_id in
            guard !isError, let isNewUser, let provider_UID else {
                print("error while signing in to firebase")
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
