//
//  CellDetailView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct CellDetailView: View {
    @EnvironmentObject var settings: UserSettings
    @Binding var task: Task
    
    var body: some View {
        
        VStack {
            
            
        }
        .navigationTitle("Routine Detail")
        
    }
}

struct CellDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Take a Warm Bath", hour: 0, minute: 30)
        CellDetailView(task: .constant(task))
            .environmentObject(UserSettings.shared)
    }
}
