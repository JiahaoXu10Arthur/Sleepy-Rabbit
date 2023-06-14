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
    @State var timer: Timer? = nil
    
    var tipofTheDay: Tip {
        modelData.tipOfTheDay ?? Tip(title: "Get Tip Failed", tag: ":(", detail: "Please check your internet connection.")
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 3) {
                ScrollView {
                    VStack(spacing: 3) {
                        TipRow(tip: tipofTheDay)
                            .padding(.bottom)
                        
                        RandomTipView(isLoading: $isLoading)
                        .frame(height: geometry.size.height * 0.7)
                    }
                }
                .onAppear{
                    startTimer()
                }
                .onDisappear{
                    timer?.invalidate()
                }
//                .refreshable {
//                    ModelData.shared.fetchTipofTheDay() {_ in}
//                }
                
                NewTipButton(isLoading: $isLoading)
            }
        }
    }
    
    func fetchData() {
        ModelData.shared.fetchTipofTheDay() { _ in
            self.startTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            self.fetchData()
        }
    }
}

struct TipPageView_Previews: PreviewProvider {
    static var previews: some View {
        TipPageView()
            .environmentObject(ModelData.shared)
            .environmentObject(UserSettings.shared)
    }
}
