//
//  RegistrationForum.swift
//  ProRep
//
//  Created by Qiang Loozen on 10/04/2023.
//

import SwiftUI

struct RegistrationForum: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: RegistrationForumViewModel

    var body: some View {
        VStack {
            Text("Finish account").font(.title)
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Form {
                    Section {
                        UnderlineTextField(icon: "person", prompt: viewModel.namePrompt) {
                            TextField("Your name", text: $viewModel.name)
                        }
                    
                        UnderlineTextField(icon: "birthday.cake") {
                            DatePicker("Birthday", selection: $viewModel.birthday, in: ...Date.now, displayedComponents: .date)
                        }
                        
                        Picker("", selection: $viewModel.gender) {
                            ForEach(Gender.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Profile")
                    }
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 5)
                    
                    Section {
                        UnderlineTextField(icon: "scalemass", prompt: viewModel.weightPrompt) {
                            TextField("weight in kg", value: $viewModel.weight, format: .number)
                                .keyboardType(.numberPad)
                        }
                        UnderlineTextField(icon: "ruler", prompt: viewModel.heightPrompt) {
                            TextField("height in cm", value: $viewModel.height, format: .number)
                                .keyboardType(.numberPad)
                        }
                    } header: {
                        Text("Body features")
                    }
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 5)
                }
            }
            
            Spacer()

            StyledButton(title: "Account maken", isLoading: viewModel.isLoading, disabled: !viewModel.isValid) {
                print("Create account")
                viewModel.createAccount()
                dismiss()
            }
        }
        .padding(15)
    }
}

struct RegistrationForum_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var vm = RegistrationForumViewModel(name: "", email: "email@email.com", provider_UID: "123")
        RegistrationForum(viewModel: vm)
    }
}
