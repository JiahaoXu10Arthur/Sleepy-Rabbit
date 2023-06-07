//
//  TipPageView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/6.
//

import SwiftUI

struct TipPageView: View {
    @State var isLoading: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 3) {
                ScrollView {
                    VStack(spacing: 3) {
                        TipRow(tip: Tip(title: "Tip of the day", tag: "#sleep#chatGPT", detail: "Drinking warm milk before bed has been shown to improve sleep quality and reduce anxiety. It relaxes the nervous system, helping you fall asleep more easily and stay asleep throughout the night. Get a cup of warm milk 30-60 minutes before bedtime to enjoy its benefits."))
                        
                        RandomTipView(isLoading: $isLoading)
                        .frame(height: geometry.size.height * 0.7)
                    }
                }
                NewTipButton(isLoading: $isLoading)
            }
        }
    }
}

struct TipPageView_Previews: PreviewProvider {
    static var previews: some View {
        TipPageView()
            .environmentObject(ModelData.shared)
    }
}
