//
//  TipDetail.swift
//  DRP_32
//
//  Created by paulodybala on 01/06/2023.
//

import SwiftUI

struct TipDetail: View {
    var tip: Tip
    var body: some View {
        
        VStack {
            
            HStack {
                Text(tip.title)
                    .font(.largeTitle)
                .padding()
                Text(tip.tag)
                    .font(.subheadline)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.yellow)
                    .cornerRadius(15)
            }
            .padding()
            

            Text(tip.detail)
                .font(.title)
                .padding()
        }
    }
}

struct TipDetail_Previews: PreviewProvider {
    static var previews: some View {
        let sample: Tip = Tip(title: "title",  tag: "tag", detail: "detail")
        if let tips = ModelData.shared.tips, !tips.isEmpty {
            TipDetail(tip: tips[0])
        } else {
            TipDetail(tip: sample)
        }
        
    }
}

