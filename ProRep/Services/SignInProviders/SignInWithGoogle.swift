//
//  SignInWithGoogle.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

final class SignInWithGoogle {
    public static let sharedInstance = SignInWithGoogle()
    
    private init() {}
    
    // MARK: Public
    public func signIn(completion: @escaping (_ credential: AuthCredential?, _ name: String?, _ email: String?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            guard error == nil else {
                print("Failed to sign into Google")
                completion(nil, nil, nil)
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                print("Failed to sign into Google")
                completion(nil, nil, nil)
                return
            }
            
            let crendential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            completion(crendential, user.profile?.name, user.profile?.email)
        }
    }
    
    // MARK: Private
    private func getRootViewController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init()}
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return .init()}
        
        return rootViewController
    }
}
