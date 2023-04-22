//
//  ExerciseService.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation
import FirebaseFirestore

enum ExerciseError: Error {
    case failedToGetExercises
}

enum ExerciseFields: String {
    case name, description
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
                completionHandler(.failure(ExerciseError.failedToGetExercises))
                return
            }
            
            let exercises = result.documents.compactMap { document in
                let data = document.data()
                let name = data[ExerciseFields.name.rawValue] as? String ?? ""
                let description = data[ExerciseFields.description.rawValue] as? String ?? ""
                return ExerciseModel(name: name, description: description)
            }
            
            completionHandler(.success(exercises))
            return
        }
        
    }
}
