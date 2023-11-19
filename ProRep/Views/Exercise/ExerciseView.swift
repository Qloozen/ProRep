//
//  ExerciseView.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct ExerciseView: View {
    @EnvironmentObject var globalViewModel: GlobalViewModel
    @State var showExerciseForum = false
    @State var showExerciseGroupForum = false

    private let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 20, alignment: .leading),
        GridItem(.flexible(), spacing: 20, alignment: .trailing),
    ]
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Text("Groups")
                    Spacer()
                    Button("Add Group") {
                        showExerciseGroupForum.toggle()
                    }
                    .fullScreenCover(isPresented: $showExerciseGroupForum) {
                        ExerciseGroupFormView(viewModel: ExerciseGroupFormViewModel())
                    }
                }
                
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(globalViewModel.groups, id: \.id) { group in
                        NavigationLink (group.name){
                            ExerciseGroupDetailsView(exerciseGroup: group)
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .lineLimit(1)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.primary)
                        .background(Color.themedGreen)
                        .cornerRadius(15)

                    }
                }
                
                HStack {
                    Text("Exercises")
                    
                    Spacer()
                    
                    Button("Add exercise") {
                        showExerciseForum.toggle()
                    }
                    .fullScreenCover(isPresented: $showExerciseForum) {
                        ExerciseFormView(
                            viewModel: ExerciseFormViewModel(
                                fetchExercises: globalViewModel.fetchExercises
                            )
                        )
                    }
                }
                
                LazyVStack {
                    ForEach(globalViewModel.exercises, id: \.id) { exercise in
                        ExerciseListButton(exercise: exercise)
                    }
                }
                
                Spacer()
            }
        }
        .padding(20)
        .navigationTitle("Exercises")
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
