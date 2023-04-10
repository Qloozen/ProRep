//
//  UserModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Codable {
    @DocumentID var id: String?
    var provider_UID: String
    var name: String
    var birthday: Date?
    var current_weight: Double
    var email: String
    var height: Double
    var gender: Gender
    @ServerTimestamp var date_created: Date?
}

enum Gender: String, Codable, CaseIterable {
    case male, female, other
}
