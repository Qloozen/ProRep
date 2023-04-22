//
//  ContentView.swift
//  ProRep
//
//  Created by Qiang Loozen on 09/04/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(CurrentUserDefaults.name.rawValue) var user: String?
    
    var body: some View {
        if user != nil {
            // Main app
            TabView {
                NavigationStack {
                    DashboardView()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "clipboard.fill")
                        Text("Dashboard")
                    }
                }
                NavigationStack {
                    ExerciseView()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "dumbbell.fill")
                        Text("Exercises")
                    }
                }

                Button("Logout", action: {
                    AuthService.sharedInstance.logOutUser { success in
                        
                    }
                })
                    .tabItem {
                        Text("Settings")
                    }
            }
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
