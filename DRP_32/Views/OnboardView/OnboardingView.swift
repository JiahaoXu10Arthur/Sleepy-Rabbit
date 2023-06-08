//
//  OnboardingView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    
    var body: some View {
        TabView{
            VStack {
                Text("Welcome")
                HStack {
                    Text("Start")
                    Image(systemName: "chevron.forward.2")
                }
            }
            BedTimeSettingView(showOnboarding: $showOnboarding)
            
        }.tabViewStyle(.page)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(showOnboarding: .constant(true))
            .environmentObject(ModelData.shared)
        
    }
}
