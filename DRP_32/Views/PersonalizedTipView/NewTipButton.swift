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
    @State private var isDisabled = false
    
    var body: some View {
        HStack {
            Button(action: {
//                isDisabled = true
                isLoading = true
                modelData.getAndCacheAiTipSync() { _ in
//                    DispatchQueue.main.async {
//                        isDisabled = false
//                    }
                }
                isLoading = false
            }) {
                Text("Random Tip")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
            }
            .disabled(isDisabled || modelData.isDisabled)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button {
                isDisabled = true
                isShowingQueryView = true
            } label: {
                Text("Query Tip")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
            }
            .disabled(isDisabled || modelData.isDisabled)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $isShowingQueryView) {
                QueryView(isShowing: $isShowingQueryView, isLoading: $isLoading, isDisabled: $isDisabled)
            }
            .onChange(of: isShowingQueryView) { newValue in
                if (!newValue && !isLoading) {
                    isDisabled = false
                }
            }

        }
        .padding()
    }
}

struct NewTipButton_Previews: PreviewProvider {
    static var previews: some View {
        NewTipButton(isLoading: .constant(false))
            .environmentObject(ModelData.shared)
    }
}
