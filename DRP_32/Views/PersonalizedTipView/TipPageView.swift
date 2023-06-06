//
//  TipPageView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/6.
//

import SwiftUI

struct TipPageView: View {
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            RandomTipView(isLoading: $isLoading)
                .padding()
            
            NewTipButton(isLoading: $isLoading)
        }
    }
}

struct TipPageView_Previews: PreviewProvider {
    static var previews: some View {
        TipPageView()
            .environmentObject(ModelData.shared)
    }
}
