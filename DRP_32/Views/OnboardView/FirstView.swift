//
//  FirstView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct FirstView: View {
    @State var showNotificationSettingsUI = false
    var task = Task(title: "Write Down a To-Do List", hour: 0, minute: 20, startHour: 15, startMinute: 03)
    @Binding var currentTab: Int
    
    var body: some View {
        
            VStack {
                
                Spacer()
                Text("Welcome")
                
                    .font(.system(size: 48, weight: .semibold))
                    .padding(.bottom)
                Text("Try to set up your first routine!")
                    .padding()
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
