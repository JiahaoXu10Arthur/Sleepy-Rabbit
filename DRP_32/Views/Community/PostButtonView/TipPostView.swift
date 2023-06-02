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
    let maxTitleLength = 30

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
                TextField("Tags...", text: $tagInput)
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
        print("posting")
        postData(urlString: "https://drp32-backend.herokuapp.com/tips",data: Tip(title: titleInput, tag: tagInput, detail: detailInput)) { (returnVal, error) in
            if let returnVal = returnVal {
                print(returnVal)
                ModelData.shared.fetchData()
            } else if let error = error {
                print(error)
            }
        }
    }
}

struct PostPage_Previews: PreviewProvider {
    static var previews: some View {
        TipPostView(isShowing: .constant(true))
    }
}
