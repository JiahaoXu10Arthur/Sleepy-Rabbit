//
//  TipPageView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/6.
//

import SwiftUI

struct TipPageView: View {
    @EnvironmentObject var modelData: ModelData
    @State var isLoading: Bool = false
    var tipofTheDay: Tip {
        modelData.tipOfTheDay ?? Tip(title: "Get Tip Failed", tag: ":(", detail: "Please check your internet connection.")
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 3) {
                ScrollView {
                    VStack(spacing: 3) {
                        TipRow(tip: tipofTheDay)
                        
                        RandomTipView(isLoading: $isLoading)
                        .frame(height: geometry.size.height * 0.7)
                    }
                }
                .refreshable {
                    ModelData.shared.fetchTipofTheDay() {_ in}
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
