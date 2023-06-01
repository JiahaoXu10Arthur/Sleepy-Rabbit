//
//  PostPage.swift
//  DRP_32
//
//  Created by paulodybala on 01/06/2023.
//

import SwiftUI

struct PostPage: View {
    @Binding var isShowing: Bool
    @State private var userInput = ""

    var body: some View {
        VStack {
            TextField("Write something...", text: $userInput)
                .padding()

            Button(action: {
                postUserInput()
                isShowing = false
            }) {
                Text("Post")
            }
            .padding()
        }
    }

    func postUserInput() {
        // Here you can do something with the userInput, like posting it to a server
        print("User Input: \(userInput)")
    }
}

struct PostPage_Previews: PreviewProvider {
    static var previews: some View {
        PostPage(isShowing: .constant(true))
    }
}
