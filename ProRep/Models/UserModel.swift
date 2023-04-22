//
//  UserModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct UserModel: Codable {
    @DocumentID var id: String?
    @ServerTimestamp var date_created: Date?
    var provider_UID: String
    var name: String
    var birthday: Date?
    var current_weight: Double
    var email: String
    var height: Double
    var gender: Gender
    var schedule: [String: String?]
}

public enum ScheduleDay: String, Codable, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

public enum Gender: String, Codable, CaseIterable {
    case male, female, other
}
