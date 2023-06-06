//
//  SwiftUIView.swift
//  DRP_32
//
//  Created by paulodybala on 02/06/2023.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct TipRow: View {
    @State private var showDetail = false
    
    var tip: Tip
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(tip.title)
                        .font(.title)
                    Text(tip.tag)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(height: 30.0)
                        .background(Color.purple)
                        .foregroundColor(.yellow)
                        .cornerRadius(100)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        
                        showDetail.toggle()
                        
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .animation(.easeInOut, value: showDetail)
                        .padding()
                }
                
            
            }
            .padding()
            
            
            
            if showDetail {
                Divider()
                
                TipDetail(tip: tip)
                    .transition(.moveAndFade)
            }
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let sample: Tip = Tip(title: "title",  tag: "tag", detail: "detail")
        
        VStack {
            TipRow(tip: sample)
                .padding()
            Spacer()
        }
            
    
        
        
    }
}
