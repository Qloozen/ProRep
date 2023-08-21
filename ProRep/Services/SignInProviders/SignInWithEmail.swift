//
//  SignInWithEmail.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseAuth

class SignInWithEmail {
    // MARK: PUBLIC
    public static let sharedInstance = SignInWithEmail()
    
    public func signIn(email: String, password: String) async throws -> UserModel? {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        do {
            let user = try await UserService.sharedInstance.getUserById(id: authResult.user.uid)
            return user
        } catch {
            return nil
        }
    }
    
    public func register(
        email: String,
        password: String
    ) async throws -> UserModel? {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        do {
            return try await UserService.sharedInstance.getUserById(id: authResult.user.uid)
        } catch {
            return nil
        }
    }
    
    // MARK: INIT
    private init() {}
}
