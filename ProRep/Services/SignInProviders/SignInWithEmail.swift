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
    
    public func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthCredential, SignInError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let authResult, let credential = authResult.credential, error == nil else {
                print("failed to login with email")
                completionHandler(.failure(.failedToSignInWithEmail))
                return
            }
          
            completionHandler(.success(credential))
        }
    }
    
    public func register(email: String, password: String, completionHandler: @escaping (Result<AuthCredential, SignInError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let authResult, let credential = authResult.credential, error == nil else {
                print("failed to register with email")
                print(String(describing: error))
                completionHandler(.failure(.failedToSignInWithEmail))
                return
            }
          
            completionHandler(.success(credential))
        }
    }
}
