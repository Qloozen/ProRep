//
//  ExerciseViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import Foundation

@MainActor class ExerciseViewModel: ObservableObject {
    @Published var exercises: [ExerciseModel] = []
    @Published var groups: [ExerciseGroupModel] = []
    
    init() {
        self.fetchGroups()
        self.fetchExercises()
    }
    
    public func fetchGroups() {
        GroupService.sharedInstance.getAllGroups {[weak self] result in
            switch result {
            case .success(let groups):
                self?.groups = groups
            case .failure(let failure):
                print(String(describing: failure))
                return
            }
        }
    }
    
    public func fetchExercises() {
        ExerciseService.sharedInstance.getAllExercises {[weak self] result in
            switch result {
            case .success(let exercises):
                self?.exercises = exercises
            case .failure(let failure):
                print(String(describing: failure))
                return
            }
        }
    }
}
