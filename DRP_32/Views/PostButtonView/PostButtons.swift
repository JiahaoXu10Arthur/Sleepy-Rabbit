//
//  PostButtons.swift
//  DRP_32
//
//  Created by 李浩基 on 01/06/2023.
//

import SwiftUI

struct PostButtons: View {
    var body: some View {
        HStack(alignment: .center) {
            
            Spacer()
            
            Text("Tip")
                .background(
                    RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                        .foregroundColor(Color.green)
                        .frame(width:120, height: 60)
                )
            
            Spacer()
            
            Text("Schedule")
                .background(
                    RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                        .foregroundColor(Color.red)
                        .frame(width: 120, height: 60)
            )
            Spacer()
        }.padding()
    }
}

struct PostButtons_Previews: PreviewProvider {
    static var previews: some View {
        PostButtons()
    }
}
