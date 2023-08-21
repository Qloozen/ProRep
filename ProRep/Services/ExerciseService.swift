//
//  ExerciseService.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation

final class ExerciseService {
    // MARK: PUBLIC
    public static let sharedInstance = ExerciseService()
    
    public func getAllExercises() async throws -> [ExerciseModel] {
        let request = APIRequest(urlPath: "exercises?userId=\(userId)")
        let response = try await APIService.sharedInstance.execute(apiRequest: request, expecting: ResponseModel<[ExerciseModel]>.self)
        return response.data
    }

    public func createExercise(exercise: CreateExerciseModel) async throws -> ExerciseModel {
        let data = try JSONEncoder().encode(exercise)
        let request = APIRequest(urlPath: "exercises", httpMethod: .POST, body: data)
        let response = try await APIService.sharedInstance.execute(apiRequest: request, expecting: ResponseModel<ExerciseModel>.self)
        return response.data
    }
    
    // MARK: PRIVATE
    private var userId: String = ""
    
    // MARK: INIT
    private init() {
        userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue) ?? ""
    }
}
