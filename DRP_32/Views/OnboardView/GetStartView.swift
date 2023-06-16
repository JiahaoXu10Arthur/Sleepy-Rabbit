//
//  GetStartView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct GetStartView: View {
    @EnvironmentObject var settings: UserSettings
    @State var isMoving = false
    var body: some View {
        VStack {
            
            Spacer()
            Text("Eveything is ready")
                .font(.system(size: 44, weight: .semibold))
                .padding(.bottom)
            
            Text("Let's jump into the rabbit hole and\nstart dreaming!")
                .multilineTextAlignment(.center)
                .padding()
            
            
            StartButtonView(isMoving: $isMoving)
                .padding(.top, 20)
            ZStack {
                
                
                Image("RabbitImage")
                    .rotationEffect(.degrees(70))
                    .padding()
                
                    .padding(.top)
                    .offset(x: 0, y:isMoving ? 300 : -50)
                    .clipped()
                    .overlay(alignment: .top) {
                        Image("hole")
                            .offset(y: 100)
                    }
                
            }
            Spacer()
        } //: BUTTON
    }
}

struct GetStartView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartView()
            .environmentObject(UserSettings.shared)
    }
}
