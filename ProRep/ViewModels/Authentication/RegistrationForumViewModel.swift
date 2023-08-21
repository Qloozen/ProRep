//
//  RegistrationForumViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseFirestore

@MainActor class RegistrationForumViewModel: ObservableObject {
    // MARK: PUBLIC
    @Published var firstname: String
    @Published var lastname: String
    @Published var birthday: Date = .now
    @Published var gender: Gender = .male
    @Published var height: Double?
    @Published var weight: Double?

    @Published var isLoading: Bool = false
        
    public var firstnamePrompt: String? {
        guard firstname.count > 0, firstname.count <= 20 else {
            return "Firstname length must be between 1 and 20"
        }
        
        return nil
    }
    
    public var lastnamePrompt: String? {
        guard lastname.count > 0, lastname.count <= 20 else {
            return "Lastname length must be between 1 and 20"
        }
        
        return nil
    }
    
    public var weightPrompt: String? {
        guard let weight, weight >= 40, weight <= 200 else {
            return "Weight must be between 40 and 200"
        }
        return nil
    }
    
    public var heightPrompt: String? {
        guard let height, height >= 100, height <= 250 else {
            return "Height must be between 100 and 250"
        }
        return nil
    }
    
    public var isValid: Bool {
        firstnamePrompt == nil && lastnamePrompt == nil && weightPrompt == nil && heightPrompt == nil
    }
    
    public func createAccount() async {
        guard let weight, let height else {
            return
        }
        self.isLoading = true
        
        let user = CreateUserModel(first_name: firstname, last_name: lastname, gender: gender, birthday: birthday, current_weight_kg: weight, height_cm: height)
        
        do {
            let user = try await UserService.sharedInstance.createUser(user: user)
            self.isLoading = false
            AuthService.sharedInstance.storeUserdata(id: user.id, name: user.first_name)
        } catch {
            self.isLoading = false
            print(String(describing: error))
            // handle error
            
        }
    }
    
    // MARK: PRIVATE
    private var email: String

    // MARK: INIT
    init(firstname: String, lastname: String, email: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
}
