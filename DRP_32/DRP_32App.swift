//
//  DRP_32App.swift
//  DRP_32
//
//  Created by DRP_32 on 2023/5/29.
//

import SwiftUI

@main
struct DRP_32App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData.shared)
                .environmentObject(UserSettings.shared)
        }
    }
}
