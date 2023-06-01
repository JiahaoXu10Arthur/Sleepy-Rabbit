//
//  TipRow.swift
//  DRP_32
//
//  Created by paulodybala on 01/06/2023.
//

import SwiftUI

struct TipRow: View {
    @State private var showDetail = false
    var body: some View {
        HStack {
            Text("Tip of the Day")
                .font(.title)
            
            Spacer()
            Text("sleeping habit")
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
            TipDetail()
        }
    }
    
}

struct TipRow_Previews: PreviewProvider {
    static var previews: some View {
        TipRow()
    }
}

