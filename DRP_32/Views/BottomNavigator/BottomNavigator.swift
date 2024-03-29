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
        case setting
        case question
    }
    
    let tabBarColor = UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 0.8)
    let selectedTabItemColor = UIColor(red: 0.6, green: 0.6, blue: 0.8, alpha: 1.0)
    let unselectedTabItemColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)


  
    
    init() {
        UITabBar.appearance().tintColor = selectedTabItemColor
        UITabBar.appearance().unselectedItemTintColor = unselectedTabItemColor
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = .white
        if #available(iOS 15.0, *) {
               let appearance = UITabBarAppearance()
               appearance.configureWithOpaqueBackground()
               appearance.backgroundColor = tabBarColor
               UITabBar.appearance().standardAppearance = appearance
               UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
           }

    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            TimeLineView()
                .tabItem {
                    Label("Routine", systemImage:"calendar")
                }
                .tag(Tab.routine)

            TipPageView()
                .tabItem {
                    Label("Questions", systemImage:"questionmark.bubble")
                }
                .tag(Tab.question)
            
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct BottomNavigator_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigator()
            .environmentObject(ModelData.shared)
            .environmentObject(UserSettings.shared)
    
    }
}
