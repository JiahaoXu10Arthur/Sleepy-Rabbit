//
//  BottomNavigator.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct BottomNavigator: View {
    @State private var selectedTab = 0
    
    var body: some View {
            TabView(selection: $selectedTab) {
                CalendarView()
                    .tabItem {
                        Label("Routine", systemImage: "calendar")
                    }
                    .tag(0)
                
                CommunityView()
                    .tabItem {
                        Label("Community", systemImage: "person.2")
                    }
                    .tag(1)
                
                QuestionView()
                    .tabItem {
                        Label("Questions", systemImage: "questionmark.bubble")
                    }
                    .tag(2)
            }
        }
}

struct BottomNavigator_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigator()
    }
}
