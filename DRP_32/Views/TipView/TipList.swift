//
//  TipList.swift
//  DRP_32
//
//  Created by paulodybala on 01/06/2023.
//

import SwiftUI

struct TipList: View {
    var intList: [Int] = Array(1...8)
    
    
    var body: some View {
        
        
        ScrollView {
            
            ForEach(intList, id: \.self) { item in
                
                TipRow()
            }

            
            .listStyle(.plain)
            
            .background(Color.clear)
            .navigationTitle("Landmarks")
        }
    }
}

struct TipList_Previews: PreviewProvider {
    static var previews: some View {
        TipList()
    }
}

