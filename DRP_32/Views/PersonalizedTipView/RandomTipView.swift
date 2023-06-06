//
//  TestView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/5.
//

import SwiftUI

struct RandomTipView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var isLoading: Bool
    
    var tip: Tip {
        modelData.showingTip ?? Tip(title: "Loading...", tag: "", detail: "")
    }

    var body: some View {
        
        
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading) {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(2)
                            .padding()
                    } else {
                        Text(tip.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        Text(tip.tag)
                            .font(.title)
                            .foregroundColor(.secondary)
                        
                        Text(tip.detail)
                            .font(.title2)
                            .padding(.top, 15)
                    }
                        
        //                Button(action: {
        //                    isLoading = true
        //                    modelData.getAnAiTip() { _ in
        //                        isLoading = false
        //                    }
        //                }) {
        //                    Text("Get New Tip")
        //                        .font(.title)
        //                        .padding()
        //                        .background(Color.blue)
        //                        .foregroundColor(.white)
        //                        .cornerRadius(10)
        //                }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        RandomTipView(isLoading: .constant(false))
            .environmentObject(ModelData.shared)
    }
}
