//
//  OutlinedExerciseCard.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct OutlinedExerciseCard: View {
    @State var exercise: ExerciseModel
    
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: "dumbbell.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                    
            VStack(alignment: .leading, spacing: 15) {
                Text(exercise.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(exercise.description)
                    .font(.caption2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.primary, lineWidth: 2)
        }
    }
}

struct OutlinedExerciseCard_Previews: PreviewProvider {
    @State static var exercise: ExerciseModel = ExerciseModel(id: 1, name: "test", description: "test")

    static var previews: some View {
        OutlinedExerciseCard(exercise: exercise)
    }
}
