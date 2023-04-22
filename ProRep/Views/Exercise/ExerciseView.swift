//
//  ExerciseView.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct ExerciseView: View {
    @StateObject var viewModel = ExerciseViewModel()
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
                        ExerciseGroupForumView()
                    }
                }
                
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(viewModel.groups, id: \.id) { group in
                        Button(group.name) {
                            
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
                        ExerciseForumView()
                    }
                }
                
                LazyVStack {
                    ForEach(viewModel.exercises, id: \.id) { exercise in
                        ExerciseRowView(exercise: exercise) {}
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
