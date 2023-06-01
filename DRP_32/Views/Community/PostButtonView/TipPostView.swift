//
//  PostPage.swift
//  DRP_32
//
//  Created by paulodybala on 01/06/2023.
//

import SwiftUI

struct TipPostView: View {
    @Binding var isShowing: Bool
    
    // store user input
    @State private var titleInput = ""
    @State private var tagInput = ""
    @State private var detailInput = ""
    let maxTitleLength = 20

    var body: some View {
        NavigationView {
            VStack {
                Divider()
                TextField("Title... Max 30 characters", text: $titleInput)
                    .padding()
                    .onChange(of: titleInput) { newValue in
                        if newValue.count > maxTitleLength {
                            titleInput = String(newValue.prefix(maxTitleLength))
                        }
                    }
                Divider()
                TextField("Tags...", text: $detailInput)
                    .padding()
                Divider()
                TextField("Details...", text: $detailInput)
                    .padding()
                Spacer()
            }
            .navigationBarTitle(Text("New Tip"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                isShowing = false
            }) {
                Text("Cancel")
            }, trailing: Button(action: {
                postUserInput()
                isShowing = false
            }) {
                Text("Post")
            })
        }
    }

    func postUserInput() {
        // Here you can do something with the userInput, like posting it to a server
        print("User input: \(titleInput) \(detailInput)")
    }
}

struct PostPage_Previews: PreviewProvider {
    static var previews: some View {
        TipPostView(isShowing: .constant(true))
    }
}
