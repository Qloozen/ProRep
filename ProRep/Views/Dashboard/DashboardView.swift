//
//  DashboardView.swift
//  ProRep
//
//  Created by Qiang Loozen on 14/04/2023.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewmodel = DashboardViewModel()
    @AppStorage(CurrentUserDefaults.user_image.rawValue) var user_image: URL?
    @State var showExerciseGroupForum = false

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
                            .id((viewmodel.days.firstIndex(of: day) ?? 0) + 1)
                        }
                    }
                }.onAppear() {
                    val.scrollTo(Date().getDayOfWeek())
                }
            }
            Text(viewmodel.displayHeader)
                .font(.headline)
            
            if let group = viewmodel.selectedGroup {
                Text(group.name)

                ForEach(group.exercises , id: \.id) { exercise in
                    OutlinedExerciseCard(exercise: exercise)
                }
            } else {
                VStack(spacing: 20) {
                    StyledButton(title: "Assign group") {
                        showExerciseGroupForum.toggle()
                    }
                    
                    StyledButton(title: "New group") {
                        print("New Group")
                    }
                    .fullScreenCover(isPresented: $showExerciseGroupForum) {
                        ExerciseGroupFormView(viewModel: ExerciseGroupFormViewModel(planned_on_day: viewmodel.selectedDay)).task {
                            await viewmodel.getSchedule()
                        }
                    }
                }.padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .padding(20)
        .toolbar {
            ToolbarItem (placement: .principal)  {
                HStack (alignment: .center) {
                    Text("Dashboard")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    NavigationLink {
                        Text("Profile")
                    } label: {
                        if let user_image {
                            AsyncImage(url: user_image) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DashboardView()
        }
    }
}
