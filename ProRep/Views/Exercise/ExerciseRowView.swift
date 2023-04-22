//
//  ExerciseRowView.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct ExerciseRowView: View {
    var exercise: ExerciseModel
    var action: () -> Void

    var body: some View {
        Button(action: action){
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

struct ExerciseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRowView(exercise: ExerciseModel(name: "test", description: "test"), action: {})
    }
}
