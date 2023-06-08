//
//  ContentView.swift
//  DRP_32
//
//  Created by DRP_32 on 2023/5/29.
//

import SwiftUI

struct ContentView: View {
    // Detect if user has onboarded
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        
        VStack {
            Button(action: {
                settings.showOnboarding = true
                settings.chosenTasks.removeAll()
            }) {
                HStack(spacing: 8) {
                    Text("Re-Start")
                    
                    Image(systemName: "arrow.right.circle")
                        .imageScale(.large)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule().strokeBorder(Color.black, lineWidth: 1.25)
                )
            } //: BUTTON
            .accentColor(Color.black)
            BottomNavigator()
        }
        .fullScreenCover(isPresented: $settings.showOnboarding, content: {
            OnboardingView()
        })
    
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData.shared)
            .environmentObject(UserSettings.shared)
    }
}
