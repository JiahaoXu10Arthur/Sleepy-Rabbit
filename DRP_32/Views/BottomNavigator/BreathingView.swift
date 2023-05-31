//
//  BreathingView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct BreathingView: View {
    var body: some View {
        VStack {
            Image(systemName: "wind")
                .foregroundColor(.blue)
            Text("This is a breather")
        }
    }
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView()
    }
}
