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
                    .font(.title2)
                    .padding()
                
                
                Button(action: {
                    currentTab += 1
                }) {
                    HStack(spacing: 8) {
                        Text("Start Setting")
                        Image(systemName: "chevron.forward.2")
                    }
                    .font(.title2)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(
                        Capsule().strokeBorder(Color.black, lineWidth: 1.25)
                    )
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
