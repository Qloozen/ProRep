//
//  GroupService.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation
import FirebaseFirestore

enum GroupError: Error {
    case failedToGetAllGroups
}

final class GroupService {
    
    public static let sharedInstance = GroupService()
    
    private let userId: String?
    private let GROUP_REF: CollectionReference
    
    // MARK: Init
    private init() {
        userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue)
        GROUP_REF = db.collection("users").document(userId ?? "").collection("exercise_groups")
    }
    
    public func getAllGroups(completionHandler: @escaping (Result<[ExerciseGroupModel], Error>) -> Void) {
        GROUP_REF.getDocuments { result, error in
            guard let result, error == nil else {
                completionHandler(.failure(GroupError.failedToGetAllGroups))
                return
            }
            let mappedResults = result.documents.compactMap { try? $0.data(as: ExerciseGroupModel.self) }
            completionHandler(.success(mappedResults))
            return
        }
    }
}

