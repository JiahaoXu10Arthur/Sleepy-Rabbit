//
//  WakeUpRoutineView.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import SwiftUI

struct WakeUpRoutineView: View {
    @EnvironmentObject var settings: UserSettings
    var tasks: [Task] {
        settings.tasks
    }
    
    var body: some View {
            
            List {
                ForEach(tasks) { task in
                    WakeUpTaskCell(task: task)
                }
            }
            .navigationTitle(Text("Wake Up Routine"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                                       StartButtonView()
                                   }
            }
            
        
    }

}

struct WakeUpRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        WakeUpRoutineView()
            .environmentObject(UserSettings.shared)
    }
}
