//
//  DayButton.swift
//  ProRep
//
//  Created by Qiang Loozen on 14/04/2023.
//

import SwiftUI

struct DayButton: View {
    var day: ScheduleDay
    @Binding var selectedDay: ScheduleDay
    
    var body: some View {
        Button {
            selectedDay = day
        } label: {
            VStack {
                VStack {
                    Text(day.rawValue.prefix(3))
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
                    .opacity(selectedDay == day ? 1.0 : 0.0)
                    .animation(.easeInOut, value: selectedDay)
            }
        }
    }
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedDay: ScheduleDay = .monday
        DayButton(day: .monday, selectedDay: $selectedDay)
    }
}
