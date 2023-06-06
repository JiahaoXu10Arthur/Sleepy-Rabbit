//
//  NewTipButton.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/6.
//

import SwiftUI

struct NewTipButton: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var isLoading: Bool
    @State private var isShowingQueryView = false
    
    var body: some View {
        HStack {
            Button(action: {
                isLoading = true
                modelData.getAnAiTip() { _ in
                    isLoading = false
                }
            }) {
                Text("Random Tip")
                    .font(.title)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button {
                isShowingQueryView = true
            } label: {
                Text("Query Tip")
                    .font(.title)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $isShowingQueryView) {
                QueryView(isShowing: $isShowingQueryView)
            }

        }
        .padding()
    }
}

struct NewTipButton_Previews: PreviewProvider {
    static var previews: some View {
        NewTipButton(isLoading: .constant(false))
    }
}
