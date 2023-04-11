//
//  PasswordField.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct PasswordField: View {
    @Binding var passwordInput: String
    var prompt: String? = nil
    @State var isVisable: Bool = false
    @FocusState var focus1: Bool
    @FocusState var focus2: Bool

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "key")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 10)

                ZStack(alignment: .trailing) {
                    Group {
                        TextField("password", text: $passwordInput)
                            .focused($focus1)
                            .opacity(isVisable ? 1 : 0)
                        
                        SecureField("password", text: $passwordInput)
                            .focused($focus2)
                            .opacity(isVisable ? 0 : 1)
                    }
                    .textFieldStyle(UnderlineTextFieldStyle(isError: prompt != nil))
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .textContentType(.password)
                    .keyboardType(.asciiCapable)

                    Button {
                        isVisable.toggle()
                        if isVisable {
                            focus1 = true
                        } else {
                            focus2 = true
                        }
                    } label: {
                        Image(systemName: isVisable ? "eye.slash": "eye")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            
            if let prompt {
                Text(prompt)
                    .font(.caption)
                    .foregroundColor(.red)
                    .italic()
            }
        }
    }
}

struct PasswordField_Previews: PreviewProvider {
    @State static var passwordInput: String = ""
    static var previews: some View {
        PasswordField(passwordInput: $passwordInput)
    }
}
