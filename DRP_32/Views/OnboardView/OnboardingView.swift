//
//  OnboardingView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct OnboardingView: View {

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Hello")
                
                    .font(.system(size: 48, weight: .semibold))
                    .padding(.bottom)
                Text("TODO: Design This page")
                    .padding()
                Spacer()
                
                
                NavigationLink(destination: BedTimeSettingView()) {
                    Text("Get Started")
                        .font(.headline)
                }
            }
            .padding()
        }
    }
    
//    var body: some View {
//        TabView{
//            VStack {
//                Text("Welcome")
//                HStack {
//                    Text("Start")
//                    Image(systemName: "chevron.forward.2")
//                }
//            }
//            BedTimeSettingView(showOnboarding: $showOnboarding)
//
//        }.tabViewStyle(.page)
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(UserSettings.shared)
            
        
    }
}
