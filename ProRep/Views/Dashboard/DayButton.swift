//
//  DayButton.swift
//  ProRep
//
//  Created by Qiang Loozen on 14/04/2023.
//

import SwiftUI

struct DayButton: View {
    var dayName: String
    var dayNumber: Int
    @Binding var selectedDay: Int
    
    var body: some View {
        Button {
            selectedDay = dayNumber
        } label: {
            VStack {
                VStack {
                    Text(dayName.prefix(3))
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 25)
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12)
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
                .frame(minWidth: 75)
                .background(.green)
                .cornerRadius(5)

                Color.gray
                    .frame(height: 3)
                    .cornerRadius(2)
                    .opacity(selectedDay == dayNumber ? 1.0 : 0.0)
                    .animation(.easeInOut, value: selectedDay)
            }
        }
    }
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedDay = 1;
        DayButton(dayName: "Monday", dayNumber: 1, selectedDay: $selectedDay)
    }
}
