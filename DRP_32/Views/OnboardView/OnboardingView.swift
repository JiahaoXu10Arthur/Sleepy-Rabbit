//
//  OnboardingView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct OnboardingView: View {
    @State var showNotificationSettingsUI = false
    
    var task = Task(title: "Write Down a To-Do List", hour: 0, minute: 20, startHour: 14, startMinute: 56)
    @State private var currentTab = 0
    
    var viewList: [Any] = [FirstView.self, BedTimeSettingView.self, BedTimeRoutineView.self, WakeUpRoutineView.self, GetStartView.self]
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            ForEach(0..<viewList.count) { index in
                VStack {
                    // Manually add a navigation bar to each tab view
                    NavigationView {
                        self.buildView(types: self.viewList, index: index)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                }
                .tag(index)
                
            }
        })
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
        
        HStack(spacing: 12) {
            ForEach(0..<viewList.count) { index in
                Capsule()
                    .foregroundColor(currentTab == index ? Color(#colorLiteral(red: 0.1951392889, green: 0.1309193373, blue: 0.4449608624, alpha: 1)) : Color.gray)
                    .frame(width: currentTab == index ? 16 : 8, height: 8)
            }
        }
        
    }
    func buildView(types: [Any], index: Int) -> AnyView {
        switch types[index].self {
        case is FirstView.Type: return AnyView( FirstView(currentTab: $currentTab) )
            
        case is BedTimeSettingView.Type: return AnyView( BedTimeSettingView() )
        case is BedTimeRoutineView.Type: return AnyView(
            BedTimeRoutineView())
            
        case is WakeUpRoutineView.Type: return AnyView(
            WakeUpRoutineView())
            
        case is GetStartView.Type: return AnyView(
            GetStartView())
            
        
            
        default: return AnyView(EmptyView())
        }
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


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(UserSettings.shared)
        
        
    }
}
