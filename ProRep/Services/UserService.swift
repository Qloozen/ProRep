//
//  UserService.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseFirestore

enum UserError: Error {
    case failedToCreateUser
}

final class UserService {
    // MARK: Properties
    public static let sharedInstance = UserService()
    private let REF_USERS = db.collection("users")
    
    private init() {}
    
    // MARK: Public
    public func createUser(user: UserModel, completionHandler: @escaping (Result<String, UserError>) -> Void) {
        do {
            let docRef = try REF_USERS.addDocument(from: user.self)
            // TODO: profile picture
            completionHandler(.success(docRef.documentID))
            return
        } catch {
            print("Failed to create account")
            completionHandler(.failure(.failedToCreateUser))
        }
    }
    
    public func getUserById(id: String, completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
        REF_USERS.document(id).getDocument(as: UserModel.self) { result in
            completionHandler(result)
        }
    }
}
