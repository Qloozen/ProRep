//
//  ExerciseGroupDetailsViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 05/10/2023.
//

import Foundation

@MainActor
class ExerciseGroupDetailsViewModel: ObservableObject {
    
    public func removeExercise(groupId: Int, exerciseId: Int) async {
        do {
            _ = try await ExerciseGroupService.sharedInstance.removeExerciseFromGroup(groupId: groupId, exerciseId: exerciseId)
        } catch {
            print(String(describing: error))
        }
    }
    
    public func addExercise(groupId: Int, exerciseId: Int) async {
        do {
            _ = try await ExerciseGroupService.sharedInstance.addExerciseToGroup(groupId: groupId, exerciseId: exerciseId)
        } catch {
            print(String(describing: error))
        }
    }
    
    public func removeGroup(groupId: Int) async {
        do {
            _ = try await ExerciseGroupService.sharedInstance.removeExerciseGroup(groupId: groupId)
        } catch {
            print(String(describing: error))
        }
    }

}
