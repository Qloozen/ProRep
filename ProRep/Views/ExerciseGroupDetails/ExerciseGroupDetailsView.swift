//
//  ExerciseGroupDetailsView.swift
//  ProRep
//
//  Created by Qiang Loozen on 27/08/2023.
//

import SwiftUI

struct ExerciseGroupDetailsView: View {
    @Environment(\.dismiss) var dismiss
    public var exerciseGroup: ExerciseGroupModel
    @State private var showAvailableExercises: Bool = false
    @StateObject private var exerciseGroupDetailsViewModel = ExerciseGroupDetailsViewModel()
    @EnvironmentObject var globalViewModel: GlobalViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(exerciseGroup.name)
                .font(.title)
                .bold()
            
            Text(exerciseGroup.description)
            
            HStack{
                Text("Exercises:")
                    .font(.headline)
                    .bold()
                
                Button("Add") {
                    showAvailableExercises.toggle()
                }
                .padding(.trailing, 5)
                .fullScreenCover(isPresented: $showAvailableExercises, content: {
                    VStack(alignment: .leading, spacing: 20) {
                        Button {
                            showAvailableExercises.toggle()
                        } label: {
                            Text("Cancel")
                        }
                    
                        Text("Available exercises")
                            .font(.title)
                
                        List {
                            ForEach(globalViewModel.exercises, id: \.id) { exercise in
                                Button(action: {
                                    Task {
                                        await exerciseGroupDetailsViewModel.addExercise(groupId: exerciseGroup.id, exerciseId: exercise.id)
                                        await globalViewModel.fetchGroups()
                                        showAvailableExercises.toggle()
                                    }
                                }, label: {
                                    Text(exercise.name)
                                })
                                .buttonStyle(PlainButtonStyle())
                                .foregroundStyle(Color(UIColor.secondarySystemBackground))
                                .listRowSeparator(.hidden)
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: 10).fill(.primary).padding(2)
                                )
                            }
                            .onDelete(perform: onDelete)
                        }
                        .listStyle(PlainListStyle())
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity)
                })
                
                
                EditButton()
            }
            .padding(.top, 100)
            .padding(.bottom, 20)
            
            List {
                ForEach(exerciseGroup.exercises, id: \.id) { exercise in
                    NavigationLink(exercise.name) {
                        HStack {
                            Image(systemName: "person")
                            Text(exercise.name)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundStyle(Color(UIColor.secondarySystemBackground))
                }
                .onDelete(perform: onDelete)
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10).fill(.primary).padding(2)
                )
            }
            .listStyle(PlainListStyle())
        }
        .padding(25)
    }
    
    func onDelete(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
    
        let exercise = exerciseGroup.exercises[index]
        
        Task {
            await exerciseGroupDetailsViewModel.removeExercise(groupId: exerciseGroup.id, exerciseId: exercise.id)
            await globalViewModel.fetchGroups()
        }
        
    }
}

struct ExerciseGroupDetailsView_Previews: PreviewProvider {
    static let exercises = (1...100).map { num in
        ExerciseModel(id: num, name: "Exercise\(num)", description: "description")
    }
    static var previews: some View {
        ExerciseGroupDetailsView(exerciseGroup: ExerciseGroupModel(id: 1, name: "Exercise group", description: "description", exercises: exercises)).environmentObject(GlobalViewModel())
    }
}
