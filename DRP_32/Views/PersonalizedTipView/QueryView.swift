//
//  QueryView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/6.
//

import SwiftUI

struct QueryView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var isShowing: Bool
    @Binding var isLoading: Bool
    
    // store user input
    @State private var queryInput = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Please enter your query here:")
                    Spacer()
                }
                .padding()
                Divider()
                TextEditor(text: $queryInput)
                    .padding()
                
                Divider()
                
                Text("The inquiry can include the sleep issues you're experiencing, along with any restrictions you'd like to impose on the generated advice.")
                    .padding()
                Spacer()
            }
            .navigationBarTitle(Text("New Tip"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                isShowing = false
            }) {
                Text("Cancel")
            }, trailing: Button(action: {
                isShowing = false
                isLoading = true
                modelData.getQueryTip(query: Query(query: queryInput)) { _ in
                    isLoading = false
                }
            }) {
                Text("Send")
            })
        }
    }
}

struct QueryView_Previews: PreviewProvider {
    static var previews: some View {
        QueryView(isShowing: .constant(true), isLoading: .constant(false))
            .environmentObject(ModelData.shared)
    }
}
