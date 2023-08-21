//
//  UserModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation

struct UserModel: Codable {
    var first_name: String
    var last_name: String
    var gender: Gender
    var birthday: String
    var current_weight_kg: Double
    var height_cm: Double
    var email: String
    var date_created: String
    var id: String
}

struct CreateUserModel: Codable {
    var first_name: String
    var last_name: String
    var gender: Gender
    var birthday: Date
    var current_weight_kg: Double
    var height_cm: Double
}

public enum Gender: String, Codable, CaseIterable {
    case male, female, other
}
