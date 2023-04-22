//
//  ExerciseGroupDetailView.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct ExerciseGroupDetailView: View {
    var group: ExerciseGroupModel
    
    var body: some View {
        VStack {
            if let exercises = group.exercises {
                Text("Exercises")
                ForEach(exercises, id: \.id) {
                    ExerciseRowView(exercise: $0) {
                        
                    }
                }
            } else {
                Text("No exercises yet")
            }

        }
    }
}

struct ExerciseGroupDetailView_Previews: PreviewProvider {
    static let group = ExerciseGroupModel(name: "name", description: "desc", exercise_ids: [])
    static var previews: some View {
        ExerciseGroupDetailView(group: group)
    }
}
