//
//  DashboardView.swift
//  ProRep
//
//  Created by Qiang Loozen on 14/04/2023.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var globalViewModel: GlobalViewModel
    @AppStorage(CurrentUserDefaults.user_image.rawValue) var user_image: URL?
    @State var showExerciseGroupForum = false
    @State var selectedDay: Int = Date().getDayOfWeek()
    let dayNames = Date().getDayNames()
    
    private var displayHeader: String {
        get {
            if globalViewModel.schedule[selectedDay] == nil {
                return "No exercises planned"
            }
            else if Date().getDayOfWeek() == selectedDay {
                return "Today's exercises"
            } else {
                return dayNames[selectedDay - 1].capitalized + " exercises"
            }
        }
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            ScrollViewReader { val in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1..<8 , id: \.self) { day in
                            DayButton(
                                dayName: dayNames[day - 1],
                                dayNumber: day,
                                selectedDay: $selectedDay
                            )
                            .id(day)
                        }
                    }
                }.onAppear() {
                    val.scrollTo(Date().getDayOfWeek())
                }
            }
            Text(displayHeader)
                .font(.headline)
            
            if let group = globalViewModel.schedule[selectedDay] ?? nil {
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
                        ExerciseGroupFormView(viewModel: ExerciseGroupFormViewModel(planned_on_day: selectedDay)).task {
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
