//
//  Rabbit.swift
//  DRP_32
//
//  Created by paulodybala on 16/06/2023.
//

import SwiftUI

struct Rabbit: View {
    @State var isMoving = false
    @State var isShowing = false
    @State private var imageOffset: CGFloat = 0.0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        isMoving.toggle()
                        
                        
                    
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                       // your function
                        isShowing.toggle()
                    }
                }) {
                    Text ("Show Subview")
                }
                .offset(y:-100)
                
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
            
            }
            
            
        }.sheet(isPresented: $isShowing) {
            Text("Hello, World!")
        
        }
        
    }
}

struct Rabbit_Previews: PreviewProvider {
    static var previews: some View {
        Rabbit()
    }
}
