//
//  LoginViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor class AuthenticationViewModel: ObservableObject {
    @Published var showError: Bool = false
    @Published var showRegistrationForm: Bool = false
    
    @Published var name: String = ""
    @Published var birthday: Date = .now
    @Published var gender: Gender = .male
    @Published var height: Double?
    @Published var weight: Double?
    private var email: String = ""
    private var provider_UID: String = ""
    
    // MARK: Public
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
    
    public func createAccount() {
        guard let weight, let height else {
            return
        }
        let user = UserModel(provider_UID: provider_UID, name: name, birthday: birthday, current_weight: weight, email: email, height: height, gender: gender)
        UserService.sharedInstance.createUser(user: user) { [weak self] result in
            switch result {
            case .success(let user_id):
                self?.getUserInfo(user_id: user_id)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    // validation
    public var namePrompt: String? {
        if name.count <= 0 || name.count > 20 {
            return "Name length must be between 1 and 20"
        } else {
            return nil
        }
    }
    
    public var weightPrompt: String? {
        if weight == nil || weight! < 40 || weight! > 200 {
            return "Weight must be between 40 and 200"
        } else {
            return nil
        }
    }
    
    public var heightPrompt: String? {
        if height == nil || height! < 100 || height! > 250 {
            return "Height must be between 100 and 250"
        } else {
            return nil
        }
    }
    
    public var isValid: Bool {
        namePrompt == nil && weightPrompt == nil && heightPrompt == nil
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
                self?.getUserInfo(user_id: user_id)
            } else {
                self?.showRegistrationForm.toggle()
            }
        }
    }
    
    private func getUserInfo(user_id: String) {
        print("Getuserinfo")
        UserService.sharedInstance.getUserById(id: user_id) { result in
            switch result {
            case .success(let model):
                UserDefaults.standard.set(model.id, forKey: CurrentUserDefaults.user_id.rawValue)
                UserDefaults.standard.set(model.name, forKey: CurrentUserDefaults.name.rawValue)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }

}
