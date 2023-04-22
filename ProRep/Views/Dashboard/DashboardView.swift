//
//  DashboardView.swift
//  ProRep
//
//  Created by Qiang Loozen on 14/04/2023.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewmodel = DashboardViewModel()
        
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            ScrollViewReader { val in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(ScheduleDay.allCases, id: \.self) { day in
                            DayButton(day: day, selectedDay: $viewmodel.selectedDay)
                                .id(day)
                        }
                    }
                }.onAppear() {
                    val.scrollTo(Date().getScheduleday(), anchor: .center)
                }
            }
            if let group = viewmodel.selectedGroup {
                VStack(alignment: .center){
                    Text(group.name).font(.title2)
                    Text(group.description).font(.caption)

                }
                .frame(maxWidth: .infinity)
                
                ForEach(["Fake exercise 1", "Fake exercise 2", "Fake exercise 3"], id: \.self) { exercise in
                    Text(exercise)
                }
            }
            Spacer()
        }
        .padding(20)
        .navigationTitle("Dashboard")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DashboardView()
        }
    }
}
