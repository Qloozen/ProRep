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
                        ForEach(viewmodel.days, id: \.self) { day in
                            
                            DayButton(
                                dayName: day,
                                dayNumber: (viewmodel.days.firstIndex(of: day) ?? 0) + 1,
                                selectedDay: $viewmodel.selectedDay
                            )
                            .id(viewmodel.days.firstIndex(of: day) ?? 0 + 1)
                        }
                    }
                }.onAppear() {
                    val.scrollTo(Date().getDayOfWeek(), anchor: .center)
                }
            }
            Text(viewmodel.displayHeader)
                .font(.headline)
            
            if let group = viewmodel.selectedGroup {
                ForEach(group.exercises ?? [], id: \.id) { exercise in
                    OutlinedExerciseCard(exercise: exercise)
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
