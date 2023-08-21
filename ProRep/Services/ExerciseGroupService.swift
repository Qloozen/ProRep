//
//  GroupService.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation

final class ExerciseGroupService {
    // MARK: PUBLIC
    public static let sharedInstance = ExerciseGroupService()
    
    public func getAllExerciseGroups() async throws -> [ExerciseGroupModel] {
        let request = APIRequest(urlPath: "exercise-groups?userId=\(userId)")
        let response = try await APIService.sharedInstance.execute(apiRequest: request, expecting: ResponseModel<[ExerciseGroupModel]>.self)
        return response.data
    }
    
    public func createExerciseGroup(exerciseGroup: CreateExerciseGroupModel) async throws -> ExerciseGroupModel {
        let data = try JSONEncoder().encode(exerciseGroup)
        let request = APIRequest(urlPath: "exercise-groups", httpMethod: .POST, body: data)
        let response = try await APIService.sharedInstance.execute(apiRequest: request, expecting: ResponseModel<ExerciseGroupModel>.self)
        return response.data
    }
    
    // MARK: PRIVATE
    private var userId: String = ""
    
    // MARK: INIT
    private init() {
        userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue) ?? ""
    }
}



