//
//  ExerciseGroupForumView.swift
//  ProRep
//
//  Created by Qiang Loozen on 22/04/2023.
//

import SwiftUI

struct ExerciseGroupFormView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var globalViewModel: GlobalViewModel
    @StateObject var viewModel: ExerciseGroupFormViewModel
    
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
            
            if (viewModel.isEditing) {
                StyledButton(title: "Update group", isLoading: viewModel.isLoading, disabled: !viewModel.isValid) {
                    dismiss()
                    Task {
                        await viewModel.updateGroup()
                        await globalViewModel.fetchGroups()
                    }
                }
            } else {
                StyledButton(title: "Create group", isLoading: viewModel.isLoading, disabled: !viewModel.isValid) {
                    dismiss()
                    Task {
                        await viewModel.createGroup()
                        await globalViewModel.fetchGroups()
                    }
                }
            }
        }.padding(20)
    }
}

struct ExerciseGroupForumView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseGroupFormView(viewModel: ExerciseGroupFormViewModel())
    }
}
