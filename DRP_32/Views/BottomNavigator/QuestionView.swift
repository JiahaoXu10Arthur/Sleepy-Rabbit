//
//  QuestionView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        VStack {
            Image(systemName: "questionmark.bubble")
                .foregroundColor(.blue)
            Text("These are questions")
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
