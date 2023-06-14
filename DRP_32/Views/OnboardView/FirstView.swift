//
//  FirstView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct FirstView: View {
    @Binding var currentTab: Int
    
    @State var showNotificationSettingsUI = false
    
    var body: some View {
        
            VStack {
                
                Spacer()
                Text("Welcome")
                
                    .font(.system(size: 48, weight: .semibold))
                    .padding(.bottom)
                Text("Try to set up your first routine!")
                    .padding()
                Button(action: {
                    NotificationManager.shared.requestAuthorization{ granted in
                        
                        // 2
                        if granted {
                            
                            showNotificationSettingsUI = true
                        }
                    }
                    
                }) {
                    HStack {
                        Image(systemName: "bell.badge.circle.fill")
                            .foregroundColor(Color.blue)
                            .font(.title)
                            .accentColor(.pink)
                        
                        Text("Enable Notification")
                            .font(.title2)
                    }
                    
                }
                
                Button(action: {
                    currentTab += 1
                }) {
                    HStack(spacing: 8) {
                        Text("Next")
                        Image(systemName: "chevron.forward.2")
                    }
                    .padding(.vertical, 10)
                }
                Spacer()
            
                
            }
            .padding()
        }
    
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(currentTab: .constant(0))
    }
}
