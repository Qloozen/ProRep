//
//  UnassignedDayView.swift
//  ProRep
//
//  Created by Qiang Loozen on 23/04/2023.
//

import SwiftUI

struct UnassignedDayView: View {
    var body: some View {
        VStack {
            StyledButton(title: "Assign group", action: {})
            StyledButton(title: "New group", action: {})
        }
    }
}

struct UnassignedDayView_Previews: PreviewProvider {
    static var previews: some View {
        UnassignedDayView()
    }
}
