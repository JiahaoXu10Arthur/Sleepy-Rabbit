//
//  AddToRoutineButton.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/14.
//

import SwiftUI

struct AddToRoutineButton: View {
    @State var isAdding: Bool = false
    var tip: Tip
    
    var body: some View {
        Button(action: {
            isAdding.toggle()
        }) {
            Image(systemName: "plus.circle")
                .font(.title)
        }
        .fullScreenCover(isPresented: $isAdding) {
            PreFedAddTaskView(tip: tip, isPresented: $isAdding)
        }
        
    }
}

struct AddToRoutineButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToRoutineButton(tip: Tip(title: "test", tag: "test", detail: "test"))
            .environmentObject(UserSettings.shared)
    }
}
