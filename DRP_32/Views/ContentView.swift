//
//  ContentView.swift
//  DRP_32
//
//  Created by DRP_32 on 2023/5/29.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    // Detect if user has onboarded
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        
        VStack {
            StartButtonView()
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
