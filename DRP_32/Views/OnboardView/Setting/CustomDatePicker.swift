//
//  CustomDatePicker.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct CustomDatePicker: View {
    @EnvironmentObject var settings: UserSettings
    
    @Binding var sleepHour: Int
    
    @Binding var sleepMinute: Int
    
    static private let maxHours = 23
    static private let maxMinutes = 59
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...11).map { $0 * 5 }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
               
                Picker(selection: $sleepHour, label: Text("")) {
                    ForEach(hours, id: \.self) { value in
                        Text("\(formatTime(_:value)) hr")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
                .labelsHidden()
                Picker(selection: $sleepMinute, label: Text("")) {
                    ForEach(minutes, id: \.self) { value in
                        Text("\(formatTime(_:value)) min")
                            .tag(value)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
                .labelsHidden()
            }
        }
    }
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatePicker(sleepHour: .constant(0), sleepMinute: .constant(0))
            .environmentObject(UserSettings.shared)
    
    }
}
