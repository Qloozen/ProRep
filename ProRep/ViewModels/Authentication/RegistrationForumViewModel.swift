//
//  RegistrationForumViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseFirestore

@MainActor class RegistrationForumViewModel: ObservableObject {
    // MARK: Properties
    @Published var name: String
    @Published var birthday: Date = .now
    @Published var gender: Gender = .male
    @Published var height: Double?
    @Published var weight: Double?

    @Published var isLoading: Bool = false
    
    private var email: String
    private var provider_UID: String
    
    public var namePrompt: String? {
        guard name.count > 0, name.count <= 20 else {
            return "Name length must be between 1 and 20"
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
        namePrompt == nil && weightPrompt == nil && heightPrompt == nil
    }
    
    // MARK: Init
    init(name: String, email: String, provider_UID: String) {
        self.name = name
        self.email = email
        self.provider_UID = provider_UID
    }
    
    // MARK: Functions
    public func createAccount() {
        guard let weight, let height else {
            return
        }
        self.isLoading = true
        
        let schedule: [String: String?] = [
            ScheduleDay.monday.rawValue: nil,
            ScheduleDay.tuesday.rawValue: nil,
            ScheduleDay.wednesday.rawValue: nil,
            ScheduleDay.thursday.rawValue: nil,
            ScheduleDay.friday.rawValue: nil,
            ScheduleDay.saturday.rawValue: nil,
            ScheduleDay.sunday.rawValue: nil
        ]
        
        let user = UserModel(provider_UID: provider_UID, name: name, birthday: birthday, current_weight: weight, email: email, height: height, gender: gender, schedule: schedule)
        UserService.sharedInstance.createUser(user: user) { [weak self] result in
            switch result {
            case .success(let user_id):
                AuthService.sharedInstance.storeUserdata(user_id: user_id)
                self?.isLoading = false
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoading = false
            }
        }
    }
}
