//
//  AuthService.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import Foundation
import FirebaseAuth

final class AuthService {
    // MARK: PUBLIC
    public static let sharedInstance = AuthService()

    public func signInToFirebase(credential: AuthCredential) async throws -> UserModel? {
        let authResult = try await Auth.auth().signIn(with: credential)
        let userUID = authResult.user.uid
        print(try await authResult.user.getIDToken())
        print(userUID)
        
        do {
            let user = try await UserService.sharedInstance.getUserById(id: userUID)
            UserDefaults.standard.set(authResult.user.photoURL, forKey: CurrentUserDefaults.user_image.rawValue)
            return user
        } catch {
            return nil
        }
    }
    
    public func storeUserdata(id: String, name: String) {
        UserDefaults.standard.set(id, forKey: CurrentUserDefaults.user_id.rawValue)
        UserDefaults.standard.set(name, forKey: CurrentUserDefaults.name.rawValue)
    }
    
    public func logOutUser(handler: @escaping (_ success: Bool) -> ()) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error logging out")
            handler(false)
            return
        }
        handler(true)
        
        let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
        defaultsDictionary.keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    // MARK: INIT
    private init() {}
}
