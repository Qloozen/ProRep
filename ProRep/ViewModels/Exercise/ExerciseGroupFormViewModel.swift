//
//  ExerciseGroupViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation
import SwiftUI

@MainActor class ExerciseGroupFormViewModel: ObservableObject {
    // MARK: PUBLIC
    @Published var nameInput: String = ""
    @Published var descriptionInput: String = ""
    @Published var isLoading = false
    
    @Published var nameError: String? = nil
    @Published var descriptionError: String? = nil
    
    var isValid: Bool { Validate.exerciseName(nameInput) == nil && Validate.exerciseDescription(descriptionInput) == nil}
        
    public func createGroup() async {
        do {
            let _ = try await ExerciseGroupService.sharedInstance.createExerciseGroup(exerciseGroup: CreateExerciseGroupModel(userId: userId, name: nameInput, description: descriptionInput, planned_on_day: nil))
            await self.fetchGroups()
        } catch {
            print(String(describing: error))
        }
    }
    
    // MARK: PRIVATE
    private var fetchGroups: () async -> Void
    private let userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue) ?? ""

    // MARK: INIT
    public init(fetchGroups: @escaping () async -> Void) {
        self.fetchGroups = fetchGroups
    }
}
