//
//  AuthService.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    // MARK: Properties
    public static let sharedInstance = AuthService()
    private let REF_USERS = db.collection("users")
    
    // MARK: Init
    private init() {}

    // MARK: Public functions
    public func signInToFirebase(credential: AuthCredential, completionHandler: @escaping (_ isError: Bool, _ isNewUser: Bool?, _ provider_UID: String?, _ user_id: String?) -> Void) {
        print("Sign into Firebase")
        Auth.auth().signIn(with: credential) { result, error in
            guard let result, error == nil else {
                print("Failed to sign into Firebase")
                completionHandler(true, nil, nil, nil)
                return
            }
            
            self.checkIfUserExist(provider_UID: result.user.uid) { user_id in
                if let user_id {
                    completionHandler(false, false, result.user.uid, user_id)
                } else {
                    completionHandler(false, true, result.user.uid, nil)
                }
            }
        }
    }
    
    public func storeUserdata(user_id: String) {
        print("Storing user data in userdefaults")
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
    
    public func checkIfUserExist(provider_UID: String, completionHandler: @escaping (_ user_id: String?) -> Void) {
        REF_USERS.whereField("provider_UID", isEqualTo: provider_UID).getDocuments { result, error in
            guard let result, result.count > 0, let user = result.documents.first, error == nil else {
                completionHandler(nil)
                return
            }
            completionHandler(user.documentID)
        }
    }
    
    // MARK: Private functions

}
