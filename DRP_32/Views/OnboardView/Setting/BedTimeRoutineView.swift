//
//  BedTimeRoutineView.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import SwiftUI

struct BedTimeRoutineView: View {
    @EnvironmentObject var settings: UserSettings
    var tasks: [Task] {
        settings.tasks
    }
    
    var body: some View {
        
        List {
            ForEach(tasks) { task in
                TaskCellView(task: task)
            }
        }
        .navigationTitle(Text("BedTime Routine"))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: WakeUpRoutineView()) {
                    HStack(spacing: 8) {
                        Text("Next")
                        Image(systemName: "arrow.right.circle")
                            .imageScale(.large)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(
                        Capsule().strokeBorder(Color.white, lineWidth: 1.25)
                    )
                }
            }
        }
        
        
    }
}

struct BedTimeRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        BedTimeRoutineView()
            .environmentObject(UserSettings.shared)
    }
}
