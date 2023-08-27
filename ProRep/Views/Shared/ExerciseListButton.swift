//
//  ExerciseListButton.swift
//  ProRep
//
//  Created by Qiang Loozen on 27/08/2023.
//

import SwiftUI

struct ExerciseListButton: View {
    @State public var exercise: ExerciseModel;
    
    var body: some View {
        Button {
            //open details
        } label: {
            HStack {
                Text(exercise.name)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .lineLimit(1)
        .font(.system(size: 12, weight: .bold))
        .foregroundColor(Color(UIColor.secondarySystemBackground))
        .background(.primary)
        .cornerRadius(15)
    }
}

struct ExerciseListButton_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListButton(exercise: ExerciseModel(id: 1, name: "Squat", description: "description"))
    }
}
