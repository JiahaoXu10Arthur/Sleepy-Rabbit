//
//  Music.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct MusicView: View {
    var body: some View {
        VStack {
            Image(systemName: "music.note")
                .foregroundColor(.blue)
            Text("This is a music player")
        }
    }
}

struct Music_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}
