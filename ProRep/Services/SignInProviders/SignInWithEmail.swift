//
//  SignInWithEmail.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseAuth

class SignInWithEmail {
    public static let sharedInstance = SignInWithEmail()
    
    private init() {}
    
    public func signIn(email: String, password: String, completionHandler: @escaping (_ user_id: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let authResult, error == nil else {
                print("failed to login with email")
                completionHandler(nil)
                return
            }
            
            AuthService.sharedInstance.checkIfUserExist(provider_UID: authResult.user.uid) { user_id in
                guard let user_id else {
                    completionHandler(nil)
                    return
                }
                completionHandler(user_id)
            }
        }
    }

    public func register(
        email: String,
        password: String,
        completionHandler: @escaping (_ isError: Bool, _ isNewUser: Bool?, _ provider_UID: String?, _ user_id: String?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let authResult, error == nil else {
                print(String(describing: error))
                completionHandler(true, nil, nil, nil)
                return
            }
            AuthService.sharedInstance.checkIfUserExist(provider_UID: authResult.user.uid) { user_id in
                guard let user_id else {
                    completionHandler(false, true, authResult.user.uid, user_id)
                    return
                }
                completionHandler(false, false, authResult.user.uid, user_id)
            }
        }
    }
}
