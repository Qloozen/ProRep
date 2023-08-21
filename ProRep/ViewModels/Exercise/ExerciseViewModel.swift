//
//  ExerciseViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation

@MainActor class ExerciseViewModel: ObservableObject {
    // MARK: PUBLIC
    @Published var exercises: [ExerciseModel] = []
    @Published var groups: [ExerciseGroupModel] = []
    
    public func fetchGroups() async {
        do {
            let groups = try await ExerciseGroupService.sharedInstance.getAllExerciseGroups()
            self.groups = groups
        } catch {
            print(String(describing: error))
        }
    }
    
    public func fetchExercises() async {
        do {
            let exercises = try await ExerciseService.sharedInstance.getAllExercises()
            self.exercises = exercises
        } catch {
            print(String(describing: error))
        }
    }
    
    // MARK: INIT
    init() {
        Task {
            await self.fetchGroups()
            await self.fetchExercises()
        }
    }
}
