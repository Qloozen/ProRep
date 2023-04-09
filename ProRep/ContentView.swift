//
//  ContentView.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if true {
            NavigationStack {
                LoginView()
            }
        } else {
            // Main app
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
