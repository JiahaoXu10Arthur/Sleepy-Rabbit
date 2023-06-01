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
            Button(action: {
                print("button pressed")
            }) {
                
                Text("Tip")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 150, height: 150)
                    .background(Color.green)
                    .cornerRadius(15)
                    .padding()
                
            }
            
            Spacer()
            Button(action: {
                
            }) {
                Text("Schedule")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 150, height: 150)
                    .background(Color.green)
                    .cornerRadius(15)
                    .padding()
                
            }
            
           
            
        }.padding()
    }
}

struct PostButtons_Previews: PreviewProvider {
    static var previews: some View {
        PostButtons()
    }
}
