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
                MusicView()
                    .tabItem {
                        Label("Music", systemImage: "music.note")
                    }
                    .tag(0)
                
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                    .tag(1)
                
                BreathingView()
                    .tabItem {
                        Label("Breathing", systemImage: "wind")
                    }
                    .tag(2)
                
                QuestionView()
                    .tabItem {
                        Label("Questions", systemImage: "questionmark.bubble")
                    }
                    .tag(3)
            }
        }
}

struct BottomNavigator_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigator()
    }
}
