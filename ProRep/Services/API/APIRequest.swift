//
//  APIRequest.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/06/2023.
//

import Foundation
import FirebaseAuth


enum HttpMethod: String {
    case GET, PUT, POST, DELETE, PATCH
}

final class APIRequest {
    // MARK: PUBLIC
    public var request: URLRequest? {
        get async throws {
            guard let url = URL(string: BASEURL +  urlPath) else {
                return nil
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if let body {
                urlRequest.httpBody = body
            }
            
            let token = try await Auth.auth().currentUser?.getIDToken()
            urlRequest.addValue(
                "Bearer \(token ?? "")",
                forHTTPHeaderField: "Authorization"
            )
            return urlRequest
        }
    }
    
    // MARK: PRIVATE
    private let urlPath: String
    private let httpMethod: HttpMethod
    private let BASEURL = "https://prorep.qloozen.nl/"
    private let body: Data?
    
    // MARK: INIT
    init(urlPath: String, httpMethod: HttpMethod = .GET, body: Data? = nil) {
        self.urlPath = urlPath
        self.httpMethod = httpMethod
        self.body = body
    }
}
