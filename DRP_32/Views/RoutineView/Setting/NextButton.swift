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
    @State private var isLinkActive = false
     var body: some View {
         NavigationLink(destination: BedTimeRoutineView(), isActive: $isLinkActive) {
             HStack(spacing: 8) {
                 Text("Next")
                 Image(systemName: "arrow.right.circle")
                     .imageScale(.large)
             }
             .padding(.horizontal, 16)
             .padding(.vertical, 10)
             .background(
                 Capsule().strokeBorder(Color.white, lineWidth: 1.25)
             )
         }
         .navigationDestination(
              isPresented: $isLinkActive) {
                   BedTimeRoutineView()
                   Text("")
                       .hidden()
              }
         .simultaneousGesture(
             TapGesture().onEnded {
                 settings.bedHour = bedHour
                 settings.bedMinute = bedMinute
                 settings.sleepHour = sleepHour
                 settings.sleepMinute = sleepMinute
                 isLinkActive = true // Activate the navigation
             }
         )
     
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(bedHour: .constant(0), bedMinute: .constant(0), sleepHour: .constant(0), sleepMinute: .constant(0))
            .environmentObject(UserSettings.shared)
    
    }
}
