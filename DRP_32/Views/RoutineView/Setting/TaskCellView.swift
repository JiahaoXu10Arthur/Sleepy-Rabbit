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
    
    @State var isChosen = false
    
    
    var body: some View {
        HStack {
            Image(systemName: isChosen ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(
                    isChosen ? .green : .gray)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                Text("\(task.hour)h \(task.minute)m")
                    .multilineTextAlignment(.leading)
               
            }
        }
        .onTapGesture {
            isChosen = !isChosen
            if isChosen {
                settings.chosenTasks.append(task)
            } else {
                if let index = settings.chosenTasks.firstIndex(of: task) {
                    settings.chosenTasks.remove(at: index)
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
