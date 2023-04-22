//
//  ScheduleService.swift
//  ProRep
//
//  Created by Qiang Loozen on 16/04/2023.
//

import Foundation
import FirebaseFirestore

enum ScheduleError: Error {
    case failedToGetSchedule
}

final class ScheduleService {
    
    public static let sharedInstance = ScheduleService()
    private let userId: String?
    private let GROUP_REF: CollectionReference
    
    // MARK: Init
    private init() {
        userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue)
        GROUP_REF = db.collection("users").document(userId ?? "").collection("exercise_groups")
    }
    
    public func getSchedule(scheduleResult: [String: String?], completionHandler: @escaping (Result<[String: ExerciseGroupModel?], Error>) -> Void) {
        var schedule: [String: ExerciseGroupModel?] = [
            ScheduleDay.monday.rawValue: nil,
            ScheduleDay.tuesday.rawValue: nil,
            ScheduleDay.wednesday.rawValue: nil,
            ScheduleDay.thursday.rawValue: nil,
            ScheduleDay.friday.rawValue: nil,
            ScheduleDay.saturday.rawValue: nil,
            ScheduleDay.sunday.rawValue: nil,
        ]
        
        var i = 0
        for key in scheduleResult.keys {
            let groupId = scheduleResult[key]!
            guard let groupId else {
                if i == scheduleResult.keys.count - 1 {
                        completionHandler(.success(schedule))
                    return
                }
                i += 1
                continue
            }
            
            GROUP_REF.document(groupId).getDocument(as: ExerciseGroupModel.self) { result in
                switch result {
                    case .success(let model):
                        schedule[key] = model
                        if i == scheduleResult.keys.count - 1 {
                                completionHandler(.success(schedule))
                            return
                        }
                    i += 1
                    case .failure(let failure):
                        print(String(describing: failure))
                        completionHandler(.failure(ScheduleError.failedToGetSchedule))
                        return
                }
            }
            
        }
    }
}
