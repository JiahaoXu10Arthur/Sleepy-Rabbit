//
//  TipList.swift
//  DRP_32
//
//  Created by paulodybala on 01/06/2023.
//

import SwiftUI

struct TipList: View {
    @EnvironmentObject var modelData: ModelData
    let testTip: Tip = Tip(title: "test", tag: "test", detail: "test")
    
    var tips: [Tip] {
        modelData.tips ?? []
    }
    
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(tips) { tip in
                    TipRow(tip: tip)
                }
                .listStyle(.plain)
                .background(Color.clear)
            }
            .refreshable {
                modelData.fetchData()
            }
            Button {
                print("posting")
                postData(urlString: "https://drp32-backend.herokuapp.com/tips",data: testTip) { (returnVal, error) in
                    if let returnVal = returnVal {
                        print(returnVal)
                    } else if let error = error {
                        print(error)
                    }
                }
            } label: {
                Text("Post")
            }
        }
    }
}

struct TipList_Previews: PreviewProvider {
    static var previews: some View {
        TipList()
            .environmentObject(ModelData.shared)
    }
}
