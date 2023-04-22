//
//  ExerciseView.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct ExerciseView: View {
    @StateObject var viewModel = ExerciseViewModel()
    private let gridItems: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Groups")
            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(viewModel.groups, id: \.id) { group in
                    Button(group.name) {
                        
                    }
                    .padding(30)
                    .frame(width: 150)
                    .lineLimit(1)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.primary)
                    .background(Color.themedGreen)
                    .cornerRadius(15)
                }
            }
            
            Spacer()
            
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
