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
    // MARK: PUBLIC
    public static let sharedInstance = SignInWithGoogle()

    public func signIn() async throws -> (credential: AuthCredential, firstname: String, lastname: String, email: String){
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw AuthError.googleSignInError
        }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController());
        
        let accessToken = result.user.accessToken.tokenString
        
        guard
            let idToken = result.user.idToken?.tokenString,
            let firstname = result.user.profile?.givenName,
            let lastname = result.user.profile?.familyName,
            let email = result.user.profile?.email
        else {
            throw AuthError.googleSignInError
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        return (credential, firstname, lastname, email)
    }
    
    // MARK: PRIVATE
    private func getRootViewController() async -> UIViewController {
        await MainActor.run {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init()}
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return .init()}
            
            return rootViewController
        }
    }
    
    // MARK: INIT
    private init() {}
}
