//
//  TaskCellView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct TaskCellView: View {
    @EnvironmentObject var settings: UserSettings
    
    @State var task: Task
    
    var body: some View {
        NavigationLink(destination: CellDetailView(task: $task)) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                    Text("\(task.hour)h \(task.minute)m")
                        .multilineTextAlignment(.leading)
                }
            }
        }
        

    }
}

struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Task Title", hour: 12, minute: 30)
        
        TaskCellView(task: task)
            .environmentObject(UserSettings.shared)
    }
}
