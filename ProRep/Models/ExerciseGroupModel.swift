//
//  ExerciseGroup.swift
//  ProRep
//
//  Created by Qiang Loozen on 16/04/2023.
//

import Foundation

struct ExerciseGroupModel: Codable {
    var id: Int
    var name: String
    var description: String
    var planned_on_day: Int?
    var exercises: [ExerciseModel]?
}

struct CreateExerciseGroupModel: Codable {
    var userId: String
    var name: String
    var description: String
    var planned_on_day: Int?
}
