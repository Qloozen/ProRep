//
//  DashboardViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 16/04/2023.
//

import Foundation
import FirebaseFirestore

@MainActor class DashboardViewModel: ObservableObject {
    @Published var userName = ""
    @Published var schedule: [String: ExerciseGroupModel?]? = nil
    @Published var selectedDay: ScheduleDay = Date().getScheduleday()
    
    public var selectedGroup: ExerciseGroupModel? {
        get {
            guard let schedule else { return nil }
            return schedule[selectedDay.rawValue, default: nil]
        }
    }
    
    public var displayHeader: String {
        get {
            if selectedGroup == nil {
                return "No exercises planned"
            }
            else if Date().getScheduleday() == selectedDay {
                return "Today's exercises"
            } else {
                return selectedDay.rawValue.capitalized + " exercises"
            }
        }
    }

    private var userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue)
    
    // MARK: Init
    init() {
        self.fetchUserData()
    }
        
    public func fetchUserData() {
        guard let userId = self.userId else { return }
        
        UserService.sharedInstance.getUserById(id: userId) {[weak self] result in
            switch result {
            case .success(let model):
                self?.userName = model.name
                self?.getSchedule(scheduleResult: model.schedule)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    private func getSchedule(scheduleResult: [String: String?]) {
        ScheduleService.sharedInstance.getSchedule(scheduleResult: scheduleResult) {[weak self] result in
            switch result {
            case .success(let model):
                self?.schedule = model
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
