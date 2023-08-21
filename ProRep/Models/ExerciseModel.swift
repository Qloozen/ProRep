//
//  ExerciseModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation

struct ExerciseModel: Codable {
    var id: Int
    var name: String
    var description: String
}

struct CreateExerciseModel: Codable {
    var userId: String
    var name: String
    var description: String
}
