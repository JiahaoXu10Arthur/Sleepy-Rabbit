//
//  WakeUpTaskCell.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import SwiftUI

struct WakeUpTaskCell: View {
    @EnvironmentObject var settings: UserSettings
    
    var task: Task
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                Text("\(task.hour)h \(task.minute)m")
                    .multilineTextAlignment(.leading)
            }
        }
       

    }
}

struct WakeUpTaskCell_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Task Title", hour: 12, minute: 30)
        
        WakeUpTaskCell(task: task)
            .environmentObject(UserSettings.shared)
    }
}
