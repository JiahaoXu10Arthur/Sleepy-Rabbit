//
//  TipList.swift
//  DRP_32
//
//  Created by paulodybala on 01/06/2023.
//

import SwiftUI

struct TipList: View {
    @EnvironmentObject var modelData: ModelData

    
    var tips: [Tip] {
        modelData.tips ?? []
    }
    
    
    var body: some View {
        
        
        ScrollView {
            
            ForEach(tips) { tip in
                
                
                TipRow(tip: tip)
            }
            .listStyle(.plain)
            
            .background(Color.clear)
        }
    }
}

struct TipList_Previews: PreviewProvider {
    static var previews: some View {
        TipList()
            .environmentObject(ModelData())
    }
}

