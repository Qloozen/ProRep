//
//  UserService.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseFirestore

final class UserService {
    // MARK: Properties
    
    public static let sharedInstance = UserService()
    private let REF_USERS = db.collection("users")
    
    private init() {}
    
    // MARK: Public
    public func createUser(user: UserModel) {
        do {
            let docRef = try REF_USERS.addDocument(from: user.self)
        } catch {
            print("Failed to create account")
        }
    }
    
    // MARK: Private

}
