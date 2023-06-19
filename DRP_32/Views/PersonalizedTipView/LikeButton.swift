//
//  LikeButton.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/7.
//

import SwiftUI

struct LikeButton: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var modelData: ModelData
    @Binding var like: Bool
    @State private var isDisabled: Bool = false
    var num: Int
    
    var body: some View {
        HStack {
            Button {
                isDisabled = true
                userSettings.liked.toggle()
                modelData.updateLike(like: userSettings.liked) { success in
                    print(success)
                    if success {
                        modelData.fetchTipofTheDay() { _ in
                            DispatchQueue.main.async {
                                isDisabled = false
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            isDisabled = false
                        }
                    }
                }
            } label: {
                Label("Toggle like", systemImage: userSettings.liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .labelStyle(.iconOnly)
                    .foregroundColor(userSettings.liked ? .pink : .gray)
            }
            .disabled(isDisabled)
            Text(num.description)
                .foregroundColor(.pink)
        }
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(like: .constant(true), num: 10)
            .environmentObject(UserSettings.shared)
    }
}
