//
//  GlobalViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 19/11/2023.
//

import Foundation

@MainActor class GlobalViewModel: ObservableObject {
    @Published var user: UserModel? = nil
    @Published var exercises: [ExerciseModel] = []
    @Published var groups: [ExerciseGroupModel] = []
    var schedule: [Int: ExerciseGroupModel?] {
        get {
            var plannedGroups: [Int: ExerciseGroupModel?] = [:]

            for day in 1...7 { plannedGroups[day] = groups.first { $0.planned_on_day == day }}
            return plannedGroups
        }
    }
    
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
    
    private func fetchUserData() async {
        let userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue)
        guard let userId = userId else { return }
        
        do {
            self.user = try await UserService.sharedInstance.getUserById(id: userId)
        }
        catch {
            print(String(describing: error))
        }
    }
    
    init() {
        Task {
            await self.fetchUserData()
            await self.fetchGroups()
            await self.fetchExercises()
        }
    }
}
