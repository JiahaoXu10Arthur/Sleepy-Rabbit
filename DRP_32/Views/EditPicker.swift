//
//  EditPicker.swift
//  DRP_32
//
//  Created by paulodybala on 17/06/2023.
//

import SwiftUI

struct EditPicker: View {
    @EnvironmentObject var settings: UserSettings
    
    @Binding var sleepHour: Int
    
    @Binding var sleepMinute: Int
    
    static private let maxHours = 23
    static private let maxMinutes = 59
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...3).map { $0 * 15 }
    
    var bedHour: Int { settings.bedHour }
    var bedMinute: Int { settings.bedMinute }
    var wakeHour: Int { settings.wakeHour }
    var wakeMinute: Int { settings.wakeMinute }
    
    @State private var startHour = 0
    @State private var startMinute = 0
    
    
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

struct EditPicker_Previews: PreviewProvider {
    static var previews: some View {
        EditPicker(sleepHour: .constant(0), sleepMinute: .constant(0)).environmentObject(UserSettings.shared)
        }
}
