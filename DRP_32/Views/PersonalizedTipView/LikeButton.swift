//
//  LikeButton.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/7.
//

import SwiftUI

struct LikeButton: View {
    @Binding var like: Bool
    @Binding var num: Int
    
    var body: some View {
        HStack {
            Button {
                like.toggle()
                if like {
                    num += 1
                } else {
                    num -= 1
                }
            } label: {
                Label("Toggle like", systemImage: like ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .labelStyle(.iconOnly)
                    .foregroundColor(like ? .pink : .gray)
            }
            Text(num.description)
                .foregroundColor(.pink)
        }
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(like: .constant(true), num: .constant(10))
    }
}
