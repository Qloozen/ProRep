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
        
        let dispatch = DispatchGroup()
        
        for key in scheduleResult.keys {
            let groupId = scheduleResult[key]!
            guard let groupId else { continue }
            dispatch.enter()
            
            GROUP_REF.document(groupId).getDocument(as: ExerciseGroupModel.self) { result in
                switch result {
                    case .success(var groupModel):
                    ExerciseService.sharedInstance.getExercises(from: groupModel.exercise_ids) { exerciseResults in
                        switch exerciseResults {
                        case .success(let exercises):
                            groupModel.exercises = exercises
                            schedule[key] = groupModel
                            dispatch.leave()
                        case .failure(let failure):
                            print(String(describing: failure))
                            completionHandler(.failure(ScheduleError.failedToGetSchedule))
                            return
                        }
                    }
                    case .failure(let failure):
                        print(String(describing: failure))
                        completionHandler(.failure(ScheduleError.failedToGetSchedule))
                        return
                }
            }
        }
        
        dispatch.notify(queue: DispatchQueue.main) {
            completionHandler(.success(schedule))
        }
    }
}
