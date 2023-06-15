//
//  TaskCellView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct TaskCellView: View {
    @EnvironmentObject var settings: UserSettings
    
    var task: Task
    
    var body: some View {
        NavigationLink(destination: CellDetailView(task: task)) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(task.title)
                        if task.type == "Bedtime" {
                            Image(systemName: "moon.haze.fill")
                                .foregroundColor(.purple)
                            
                        } else if task.type == "Sleep" {
                            Image(systemName: "moon.zzz.fill")
                                .foregroundColor(.blue)
                            
                        } else {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.orange)
                            
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("\(task.hour)h \(task.minute)m")
                            .multilineTextAlignment(.leading)
                        if task.startHour > -1 {
                            HStack {
                                Text("\(formatTime(_:task.startHour)):\(formatTime(_:task.startMinute))")
                                Text(" - ")
                                createTime()
                            }
                           
                            
                        
                        }
                    }
                    .font(.headline)
                }
            }
        }
        

    }
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    func createTime() -> some View {
        var hour = task.startHour + task.hour
        var minute = task.startMinute + task.minute
        if minute > 59 {
            minute = minute - 60
            hour += 1
        }
        if hour > 23 {
            hour = hour - 24
        }
        return Text("\(formatTime(_:hour)):\(formatTime(_:minute))")
    }
}

struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Task Title", hour: 12, minute: 30, startHour: 12, startMinute: 30)
        
        TaskCellView(task: task)
            .environmentObject(UserSettings.shared)
    }
}
