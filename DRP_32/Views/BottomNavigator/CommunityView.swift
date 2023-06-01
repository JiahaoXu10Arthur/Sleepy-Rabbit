//
//  BreathingView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        TipList()
    }
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
            .environmentObject(ModelData())
    }
}
