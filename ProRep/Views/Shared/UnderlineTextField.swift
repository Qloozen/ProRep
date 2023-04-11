//
//  UnderlineTextField.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct UnderlineTextField<Content: View>: View {
    var icon: String
    var content: Content
    var prompt: String?
    
    init(icon: String, prompt: String? = nil, @ViewBuilder _ content: () -> Content) {
        self.icon = icon
        self.prompt = prompt
        self.content = content()
    }
            
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 10)
                
                content

            }
            if let prompt {
                Text(prompt)
                    .font(.caption)
                    .foregroundColor(.red)
                    .italic()
            }
        }
        .textFieldStyle(UnderlineTextFieldStyle(isError: prompt != nil))
    }
}

struct UnderlineTextFieldStyle: TextFieldStyle {
    var isError: Bool
    
    init (isError: Bool = false) {
        self.isError = isError
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 10)
            .background {
                VStack {
                    Spacer()
                    if isError {
                        Color.red
                            .frame(height: 2)
                    } else {
                        Color.gray
                            .frame(height: 2)
                    }

                }
            }
            .cornerRadius(5)
    }
}



struct UnderlineTextField_Previews: PreviewProvider {
    @State static var textInput: String = "hello"
    static var previews: some View {
        UnderlineTextField(icon: "person", prompt: "kaas") {
            TextField("email", text: $textInput)
        }
    }
}
