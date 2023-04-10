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
    
    private init() {}

    // MARK: Public
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
    
    // MARK: Private
    private func checkIfUserExist(provider_UID: String, completionHandler: @escaping (_ user_id: String?) -> Void) {
        REF_USERS.whereField("provider_UUID", isEqualTo: provider_UID).getDocuments { result, error in
            guard let result, result.count > 0, let user = result.documents.first, error == nil else {
                completionHandler(nil)
                return
            }
            completionHandler(user.documentID)
        }
    }
}
