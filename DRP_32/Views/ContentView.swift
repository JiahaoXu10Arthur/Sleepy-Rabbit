//
//  ContentView.swift
//  DRP_32
//
//  Created by DRP_32 on 2023/5/29.
//

import SwiftUI

struct ContentView: View {
    // Detect if user has onboarded
    @AppStorage("userOnboarded") var userOnboarded: Bool = true//false
    
    var body: some View {
        if userOnboarded {
            BottomNavigator()
        } else {
            //OnboardingView()
            VStack {
                Text ("Tap button to onboard user.")
                    .font (Font.system(size: 50))
                Button( action: {
                    userOnboarded = true
                }) {
                    Text ("Tap Me")
                        .font (Font.system(size: 80))
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData.shared)
    }
}
