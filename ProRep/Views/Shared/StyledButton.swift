//
//  StyledButton.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct StyledButton: View {
    var title: String
    var color: Color?
    var action: () -> ()
    
    var body: some View {
        Button(title, action: action)
            .background(color == nil ? Color.themedGreen : color)
            .cornerRadius(10)
            .buttonStyle(BorderButtonStyle())
    }
}

struct BorderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(15)
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
            .fontWeight(.bold)
            .font(.system(size: 18))
    }
}

struct StyledButton_Previews: PreviewProvider {
    
    static var previews: some View {
        StyledButton(title: "Testbutton") {
            print("Button action works")
        }
    }
}
