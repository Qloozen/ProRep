//
//  UserService.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation

final class UserService {
    // MARK: PUBLIC
    public static let sharedInstance = UserService()
    
    public func createUser(user: CreateUserModel) async throws -> UserModel {
        let jsonData = try JSONEncoder().encode(user)
        let request = APIRequest(urlPath: "users", httpMethod: .POST, body: jsonData)
        let response = try await APIService.sharedInstance.execute(apiRequest: request, expecting: ResponseModel<UserModel>.self)
        return response.data
    }
    
    public func getUserById(id: String) async throws -> UserModel {
        let request = APIRequest(urlPath: "users/\(id)")
        let response = try await APIService.sharedInstance.execute(apiRequest: request, expecting: ResponseModel<UserModel>.self)
        return response.data
    }
    
    // MARK: INIT
    private init() {}
}
