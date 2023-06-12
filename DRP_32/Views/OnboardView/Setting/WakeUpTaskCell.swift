//
//  WakeUpTaskCell.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import SwiftUI

struct WakeUpTaskCell: View {
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
                settings.wakeUpChosenTasks.append(task)
            } else {
                if let index = settings.wakeUpChosenTasks.firstIndex(of: task) {
                    settings.wakeUpChosenTasks.remove(at: index)
                }
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
