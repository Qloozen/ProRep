//
//  UnderlineTextField.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct UnderlineTextField: View {
    @Binding var textInput: String
    var hint: String
    var icon: String
        
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            TextField(hint, text: $textInput)
        }
        .textFieldStyle(UnderlineTextFieldStyle())
    }
}

struct UnderlineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 10)
            .background {
                VStack {
                    Spacer()
                    Color.gray
                        .frame(height: 2)
                }
            }
            .cornerRadius(5)
    }
}



struct UnderlineTextField_Previews: PreviewProvider {
    @State static var textInput: String = ""
    static var previews: some View {
        UnderlineTextField(textInput: $textInput, hint: "example.com", icon: "key")
    }
}
