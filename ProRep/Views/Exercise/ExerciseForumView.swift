//
//  ExerciseForumView.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct ExerciseForumView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ExerciseForumViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
            
            Spacer()

            UnderlineTextField(icon: "person", prompt: viewModel.nameError) {
                TextField("name", text: $viewModel.nameInput)
            }
            .onChange(of: viewModel.nameInput) { newValue in
                viewModel.nameError = Validate.exerciseName(newValue)
            }
            
            UnderlineTextField(icon: "person", prompt: viewModel.descriptionError) {
                TextField("description", text: $viewModel.descriptionInput)
            }
            .onChange(of: viewModel.descriptionInput) { newValue in
                viewModel.descriptionError = Validate.exerciseDescription(newValue)
            }
            
            Spacer()
            
            StyledButton(title: "Create exercise", isLoading: viewModel.isLoading, disabled: !viewModel.isValid) {
                dismiss()
                viewModel.createExercise()
            }
        }.padding(20)
    }
}

struct ExerciseForumView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseForumView()
    }
}
