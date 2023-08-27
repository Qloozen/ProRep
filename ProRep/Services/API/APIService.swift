//
//  APIService.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/06/2023.
//

import Foundation

final class APIService {
    enum APIError: Error {
        case failedToCreateRequest
    }
    
    public static let sharedInstance = APIService()
    
    private init() {}

    public func execute<T: Codable>(
        apiRequest: APIRequest,
        expecting type: T.Type
    ) async throws -> T {
        guard let urlRequest = try await apiRequest.request else {
            throw APIError.failedToCreateRequest
        }

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
        let decoded = try JSONDecoder().decode(type.self, from: data)

        return decoded
    }
}
