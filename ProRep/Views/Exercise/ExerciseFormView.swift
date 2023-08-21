//
//  ExerciseForumView.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct ExerciseFormView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: ExerciseFormViewModel
    
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
                Task { await viewModel.createExercise()}
                dismiss()
            }
        }.padding(20)
    }
}

struct ExerciseForumView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseFormView(viewModel: ExerciseFormViewModel(fetchExercises: {}))
    }
}
