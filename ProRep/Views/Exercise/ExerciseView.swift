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
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .trailing),
    ]
    var body: some View {
        ScrollView {
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
                
                Text("Exercises")
                
                LazyVStack {
                    ForEach(viewModel.exercises, id: \.id) { exercise in
                        Button {
                            
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
