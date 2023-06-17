//
//  CustomErrors.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation

enum AuthError: Error {
    case googleSignInError
    case failedToSignInWithEmail
}
