//
//  SignInProviderProtocol.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseAuth

protocol SignInProviderProtocol {
    func signIn(completion: @escaping (_ credential: AuthCredential?, _ name: String?, _ email: String?) -> Void)
}


