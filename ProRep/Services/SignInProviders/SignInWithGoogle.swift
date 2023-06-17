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
    public func signIn() async throws -> (credential: AuthCredential, name: String, email: String){
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
            let userName = result.user.profile?.name,
            let email = result.user.profile?.email
        else {
            throw AuthError.googleSignInError
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        return (credential, userName, email)
    }
    
    // MARK: Private
    private func getRootViewController() async -> UIViewController {
        await MainActor.run {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init()}
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return .init()}
            
            return rootViewController
        }
    }
}
