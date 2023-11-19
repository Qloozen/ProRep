//
//  GlobalViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 19/11/2023.
//

import Foundation

class GlobalViewModel: ObservableObject {
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
    
    init() {
        Task {
            await self.fetchGroups()
            await self.fetchExercises()
        }
    }
}
