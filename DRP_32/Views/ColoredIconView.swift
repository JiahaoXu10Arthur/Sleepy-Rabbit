//
//  ColoredIconView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct ColoredIconView: View {

    let imageName: String
    let foregroundColor: Color
    let backgroundColor: Color
    @State private var frameSize: CGSize = CGSize(width: 30, height: 30)
    @State private var cornerRadius: CGFloat = 5
    
    var body: some View {
        Image(systemName: imageName)
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SFSymbolKey.self, value: max(proxy.size.width, proxy.size.height))
                }
            )
            .onPreferenceChange(SFSymbolKey.self) {
                let size = $0 * 1.05
                frameSize = CGSize(width:size, height: size)
                cornerRadius = $0 / 6.4
            }
            .frame(width: frameSize.width, height: frameSize.height)
            .foregroundColor(foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
            )
    }
}

fileprivate struct SFSymbolKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ColoredIconView_Previews: PreviewProvider {
    static var previews: some View {
        ColoredIconView(imageName: "sun.max", foregroundColor: .white, backgroundColor: .orange)
    }
}
