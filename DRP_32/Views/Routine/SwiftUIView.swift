//
//  SwiftUIView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct SwiftUIView: View {
    @State var hours: Int = 0
    @State var minutes: Int = 0

    var body: some View {
                HStack {
                    Picker("", selection: $hours){
                        ForEach(0..<4, id: \.self) { i in
                            Text("\(i) hours").tag(i)
                        }
                    }.pickerStyle(WheelPickerStyle())
                        .labelsHidden()
                        .frame(width: 100).clipped()
                    Picker("", selection: $minutes){
                        ForEach(0..<60, id: \.self) { i in
                            Text("\(i) min").tag(i)
                        }
                    }.pickerStyle(WheelPickerStyle())
                        .frame(width: 100).clipped()
        }.padding(.horizontal)
    }
}

struct AAAView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
