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
    @Published var nameInput: String
    @Published var descriptionInput: String
    @Published var isLoading = false
    
    @Published var nameError: String? = nil
    @Published var descriptionError: String? = nil
    
    var isEditing: Bool = false
    var isValid: Bool { Validate.exerciseName(nameInput) == nil && Validate.exerciseDescription(descriptionInput) == nil}
    
    private var groupId: Int? = nil
        
    public func createGroup() async {
        do {
            let _ = try await ExerciseGroupService.sharedInstance.createExerciseGroup(exerciseGroup: CreateExerciseGroupModel(name: nameInput, description: descriptionInput, planned_on_day: plannedOnDay))
        } catch {
            print(String(describing: error))
        }
    }
    
    public func updateGroup() async {
        guard let groupId else { return }
        
        do {
            let _ = try await ExerciseGroupService.sharedInstance.patchExerciseGroup(groupId: groupId, exerciseGroup: PatchExerciseGroupModel(name: self.nameInput, description: self.descriptionInput))
        } catch {
            print(String(describing: error))
        }
    }
    
    // MARK: PRIVATE
    private var plannedOnDay: Int?
    private let userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue) ?? ""

    // MARK: INIT
    public init(planned_on_day: Int? = nil, exerciseGroup: ExerciseGroupModel? = nil) {
        self.plannedOnDay = planned_on_day
        self.nameInput = exerciseGroup?.name ?? ""
        self.descriptionInput = exerciseGroup?.description ?? ""
        
        if let exerciseGroup  {
            self.groupId = exerciseGroup.id
            self.isEditing = true
        }
    }
}
