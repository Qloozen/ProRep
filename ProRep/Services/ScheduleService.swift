//
//  ScheduleService.swift
//  ProRep
//
//  Created by Qiang Loozen on 16/04/2023.
//

import Foundation

final class ScheduleService {
    // MARK: PUBLIC
    public static let sharedInstance = ScheduleService()

    public func getSchedule() async throws -> [ExerciseGroupModel] {
        let request = APIRequest(urlPath: "exercise-groups/planned?userId=\(userId)")
        let response = try await APIService.sharedInstance.execute(apiRequest: request, expecting: ResponseModel<[ExerciseGroupModel]>.self)
        return response.data
    }
    
    // MARK: PRIVATE
    private var userId: String = ""
    
    // MARK: INIT
    private init() {
        userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue) ?? ""
    }
}
