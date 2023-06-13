//
//  NextButton.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import SwiftUI

struct NextButton: View {
    @EnvironmentObject var settings: UserSettings
    
    @Binding var bedHour: Int
    @Binding var bedMinute: Int
    @Binding var sleepHour: Int
    @Binding var sleepMinute: Int
    @Binding var wakeHour: Int
    @Binding var wakeMinute: Int
    
    
    @State private var isLinkActive = false
    var body: some View {
        Button(action: {
            settings.bedHour = bedHour
            settings.bedMinute = bedMinute
            settings.sleepHour = sleepHour
            settings.sleepMinute = sleepMinute
            settings.wakeHour = wakeHour
            settings.wakeMinute = wakeMinute
        }) {
            HStack(spacing: 8) {
                Text("Save")
            }
            .padding(.vertical, 10)
        }
        
    }
    
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(bedHour: .constant(0), bedMinute: .constant(0), sleepHour: .constant(0), sleepMinute: .constant(0), wakeHour: .constant(0), wakeMinute: .constant(0))
            .environmentObject(UserSettings.shared)
        
    }
}
