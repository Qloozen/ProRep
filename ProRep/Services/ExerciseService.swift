//
//  ExerciseService.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation
import FirebaseFirestore

enum ExerciseError: Error {
    case failedToGetExercisesForGroup
    case failedToGetAllExercises
    case failedToCreateAnExercise
}

final class ExerciseService {
    
    public static let sharedInstance = ExerciseService()
    
    private let userId: String?
    private let EXERCISE_REF: CollectionReference
    
    // MARK: Init
    private init() {
        userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue)
        EXERCISE_REF = db.collection("users").document(userId ?? "").collection("exercises")
    }
    
    public func getExercises(from ids: [String], completionHandler: @escaping (Result<[ExerciseModel], Error>) -> Void) {
        EXERCISE_REF.whereField(FieldPath.documentID(), in: ids).getDocuments { result, error in
            guard let result, error == nil else {
                completionHandler(.failure(ExerciseError.failedToGetExercisesForGroup))
                return
            }
            
            let exercises = result.documents.compactMap { try? $0.data(as: ExerciseModel.self) }
            
            completionHandler(.success(exercises))
            return
        }
    }
    
    public func getAllExercises(completionHandler: @escaping (Result<[ExerciseModel], Error>) -> Void) {
        EXERCISE_REF.addSnapshotListener { result, error in
            guard let result, error == nil else {
                completionHandler(.failure(ExerciseError.failedToGetAllExercises))
                return
            }
            
            let exercises = result.documents.compactMap { try? $0.data(as: ExerciseModel.self) }
            
            completionHandler(.success(exercises))
            return
        }
    }
    
    public func createExercise(exercise: ExerciseModel, completionHandler: @escaping (Result<String, Error>) -> Void) {
        do {
            try EXERCISE_REF.addDocument(from: exercise)
            completionHandler(.success("success"))
        }
        catch {
            print(String(describing: error))
            completionHandler(.failure(ExerciseError.failedToCreateAnExercise))
        }
    }
}
