//
//  DashboardViewModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 16/04/2023.
//

import Foundation

@MainActor class DashboardViewModel: ObservableObject {
    // MARK: PUBLIC
    @Published var userName = ""
    @Published var schedule: [ExerciseGroupModel] = []
    @Published var selectedDay = Date().getDayOfWeek()
    
    public let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    public var selectedGroup: ExerciseGroupModel? {
        get {
            schedule.first { group in
                group.planned_on_day == selectedDay
            }
        }
    }
    
    public var displayHeader: String {
        get {
            if selectedGroup == nil {
                return "No exercises planned"
            }
            else if Date().getDayOfWeek() == selectedDay {
                return "Today's exercises"
            } else {
                return days[selectedDay - 1].capitalized + " exercises"
            }
        }
    }
    
    // MARK: PRIVATE
    private var userId = UserDefaults.standard.string(forKey: CurrentUserDefaults.user_id.rawValue)
    
    private func fetchUserData() async {
        guard let userId = self.userId else { return }
        
        do {
            let user = try await UserService.sharedInstance.getUserById(id: userId)
            self.userName = user.first_name
        }
        catch {
            print(String(describing: error))
        }
    }
    
    private func getSchedule() async {
        do {
            let schedule = try await ScheduleService.sharedInstance.getSchedule()
            self.schedule = schedule
        } catch {
            print(String(describing: error))
        }
    }
    
    // MARK: Init
    init() {
        Task {
            await self.fetchUserData()
            await self.getSchedule()
        }
    }
}
