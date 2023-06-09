//
//  WakeUpTimePickerView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct WakeUpTimePickerView: View {
    
    @Binding var wakeHour: Int
    @Binding var wakeMinute: Int
    
    static private let maxHours = 23
    static private let maxMinutes = 59
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...11).map { $0 * 5 }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
               
                Picker(selection: $wakeHour, label: Text("")) {
                    ForEach(hours, id: \.self) { value in
                        Text("\(formatTime(_:value))")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width * 25 / 51, alignment: .center)
                .labelsHidden()
                
                Text(":")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: geometry.size.width / 51, alignment: .center)
                
                Picker(selection: $wakeMinute, label: Text("")) {
                    ForEach(minutes, id: \.self) { value in
                        Text("\(formatTime(_:value))")
                            .tag(value)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width * 25 / 51, alignment: .center)
                .labelsHidden()
            }
        }
    }
    
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    
}

struct WakeUpTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        WakeUpTimePickerView(wakeHour: .constant(0), wakeMinute: .constant(0))

    }
}
