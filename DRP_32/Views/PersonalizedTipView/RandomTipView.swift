//
//  TestView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/5.
//

import SwiftUI


struct RandomTipView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var modelData: ModelData
    @Binding var isLoading: Bool
    
    var tip: Tip {
        modelData.showingTip ?? Tip(title: "White Noise for Better Sleep", tag: "#sleep#chatGPT", detail: "Playing white noise in the background during sleep can help drown out external noise and create a calming environment. This can lead to better sleep quality and more restful nights.")
    }

    var body: some View {
        
        
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading) {
                    if (isLoading || modelData.isLoading) {
                        ProgressView()
                            .scaleEffect(2)
                            .padding()
                    } else {
                        HStack {
                            Text(tip.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.primary)
                            Spacer()
                            AddToRoutineButton(tip: tip)
                        }
                        
                        Text(tip.tag)
                            .font(.title2)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.secondary)
                        
                        ScrollView {
                            Text(tip.detail)
                                .font(.title2)
                                .padding(.top, 15)
                                .foregroundColor(.primary)
                        }
                        .frame(height: geometry.size.height * 0.6)
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(15)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.2),radius: 10)
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
            .environmentObject(UserSettings.shared)
    }
}
