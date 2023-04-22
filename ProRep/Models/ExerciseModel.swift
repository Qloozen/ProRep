//
//  ExerciseModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct ExerciseModel: Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
}
