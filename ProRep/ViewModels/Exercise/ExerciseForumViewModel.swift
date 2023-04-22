//
//  ExerciseForumViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation
import SwiftUI

@MainActor class ExerciseForumViewModel: ObservableObject {
    @Published var nameInput: String = ""
    @Published var descriptionInput: String = ""
    @Published var isLoading = false
    
    @Published var nameError: String? = nil
    @Published var descriptionError: String? = nil
    
    @Environment(\.dismiss) private var dismiss

    var isValid: Bool { Validate.exerciseName(nameInput) == nil && Validate.exerciseDescription(descriptionInput) == nil}
    
    public func createExercise() {
        self.isLoading = true

        ExerciseService.sharedInstance.createExercise(exercise: ExerciseModel(name: nameInput, description: descriptionInput)) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(_):
                self?.dismiss()
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }

}
