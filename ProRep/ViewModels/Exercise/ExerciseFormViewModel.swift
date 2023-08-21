//
//  ExerciseForumViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation
import SwiftUI

@MainActor class ExerciseFormViewModel: ObservableObject {
    // MARK: PUBLIC
    @Published var nameInput: String = ""
    @Published var descriptionInput: String = ""
    @Published var isLoading = false
    
    @Published var nameError: String? = nil
    @Published var descriptionError: String? = nil
    
    var isValid: Bool { Validate.exerciseName(nameInput) == nil && Validate.exerciseDescription(descriptionInput) == nil}
        
    public func createExercise() async {
        self.isLoading = true
        
        do {
            let _ = try await ExerciseService.sharedInstance.createExercise(exercise: CreateExerciseModel(userId: userId, name: nameInput, description: descriptionInput))
            await fetchExercises()
        } catch {
            // Handle error
            print(String(describing: error))
        }
    }
    
    // MARK: PRIVATE
    private let userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue) ?? ""
    private var fetchExercises: () async -> Void
    
    
    // MARK: INIT
    public init(fetchExercises: @escaping () async -> Void) {
        self.fetchExercises = fetchExercises
    }
}
