//
//  ExerciseGroup.swift
//  ProRep
//
//  Created by Qiang Loozen on 16/04/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct ExerciseGroupModel: Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var exercises: [ExerciseModel]?
    var exercise_ids: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, exercise_ids
    }
}
