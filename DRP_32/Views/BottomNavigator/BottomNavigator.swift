//
//  BottomNavigator.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct BottomNavigator: View {
    
    @State private var selection: Tab = .routine

    enum Tab {
        case routine
        case community
        case question
    }
    
    let tabBarColor = UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0)
  
    
    init() {
           UITabBar.appearance().backgroundColor = tabBarColor
    }
    
    var body: some View {
            TabView(selection: $selection) {
                CalendarView()
                    .tabItem {
                        Label("Routine", systemImage: "calendar")
                    }
                    .tag(Tab.routine)
                
                CommunityView()
                    .tabItem {
                        Label("Community", systemImage: "person.2")
                    }
                    .tag(Tab.community)
                
                
                QuestionView()
                    .tabItem {
                        Label("Questions", systemImage: "questionmark.bubble")
                    }
                    .tag(Tab.question)
            }
        }
}

struct BottomNavigator_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigator()
    }
}
