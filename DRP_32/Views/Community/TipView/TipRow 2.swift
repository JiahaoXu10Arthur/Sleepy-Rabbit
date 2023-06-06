//
//  TipRow.swift
//  DRP_32
//
//  Created by paulodybala on 01/06/2023.
//

import SwiftUI

struct TipRow: View {
    @State private var showDetail = false
    
    var tip: Tip
    var body: some View {
        HStack {
            Text(tip.title)
                .font(.title)
            
            Spacer()
            Text(tip.tag)
                .font(.subheadline)
                .padding()
                .background(Color.purple)
                .foregroundColor(.yellow)
                .cornerRadius(15)
        
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding()
        .onTapGesture {
            self.showDetail = true
        }
        .sheet(isPresented: $showDetail) {
            TipDetail(tip: tip)
        }
    }
    
}

struct TipRow_Previews: PreviewProvider {
    static var previews: some View {
        let sample: Tip = Tip(title: "title",  tag: "tag", detail: "detail")
        if let tips = ModelData.shared.tips, !tips.isEmpty {
            TipRow(tip: tips[0])
        } else {
            TipRow(tip: sample)
        }
    }
}

