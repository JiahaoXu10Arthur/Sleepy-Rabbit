//
//  NewTaskButton.swift
//  DRP_32
//
//  Created by paulodybala on 12/06/2023.
//

import SwiftUI

struct NewTaskButton: View {
    @EnvironmentObject var settings: UserSettings
    
    @Binding var title: String
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var taskHour: Int
    @Binding var taskMinute: Int
    
    @Binding var isAutomatic: Bool
    
    @Binding var selectedType: String
    
    @Binding var detail: String
    
    @Binding var isPresented: Bool
    
    var bedHour: Int { settings.bedHour }
    var bedMinute: Int { settings.bedMinute }
    var sleepHour: Int { settings.sleepHour }
    var sleepMinute: Int { settings.sleepMinute }
    var wakeHour: Int { settings.wakeHour }
    var wakeMinute: Int { settings.wakeMinute }
 
    @State private var startHour = 0
    @State private var startMinute = 0
    
    var body: some View {
        Button (action: {
            let task = Task(title: title, hour: hour, minute: minute, startHour: taskHour, startMinute: taskMinute, detail: detail)
            if selectedType == "BedTime" {
                settings.bedTimeRoutine.append(task)
                settings.bedTimeChosenTasks.append(task)
            } else {
                settings.wakeUpRoutine.append(task)
                settings.wakeUpChosenTasks.append(task)
            }
            isPresented.toggle()
            update()
        
        }) {
            HStack(spacing: 8) {
                Text("Save")
            }
            .padding(.vertical, 10)
        }

        
    }
    func update() {
        settings.bedTimeChosenTasks = settings.bedTimeChosenTasks.filter { $0.title != "Sleep"}
        
        let sleep = Task(title: "Sleep", hour: sleepHour, minute: sleepMinute, startHour: bedHour, startMinute: bedMinute)
        startHour = bedHour
        startMinute = bedMinute
        var tasks: [Task] = [sleep]
        
        for task in settings.bedTimeRoutine {
            tasks.append(updateTask(task: task))
        }
        
        settings.bedTimeChosenTasks = tasks
        
        startHour = wakeHour
        startMinute = wakeMinute
        
       
        
        tasks = []
        
        for task in settings.wakeUpRoutine {
            tasks.append(updateTask2(task: task))
        }
        
        settings.wakeUpChosenTasks = tasks
        print("here")
    }
    
    func updateStart(hour: Int, minute: Int) {
        startHour = startHour - hour
        startMinute = startMinute - minute
        if startMinute < 0 {
            startMinute = 60 + startMinute
            startHour -= 1
        }
        if startHour < 0 {
            startHour = 24 + startHour
        }
    }
    
    func updateTask(task: Task) -> Task {
        updateStart(hour: task.hour, minute: task.minute)
        
        let task = Task(title: task.title, hour: task.hour, minute: task.minute, startHour: startHour, startMinute: startMinute, detail: task.detail)
        
        return task
    }
    
    func updateStart2(hour: Int, minute: Int) {
        startHour = startHour + hour
        startMinute = startMinute + minute
        if startMinute > 59 {
            startMinute = startMinute - 60
            startHour += 1
        }
        if startHour > 23 {
            startHour = startHour - 24
        }
    }
    
    func updateTask2(task: Task) -> Task {
        let task = Task(title: task.title, hour: task.hour, minute: task.minute, startHour: startHour, startMinute: startMinute, detail: task.detail)
        updateStart2(hour: task.hour, minute: task.minute)
        
        return task
    }
}

struct NewTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskButton(title: .constant("Test"), hour: .constant(0), minute: .constant(0), taskHour: .constant(-1), taskMinute: .constant(-1), isAutomatic: .constant(true), selectedType: .constant("BedTime"), detail: .constant("Test"), isPresented: .constant(true))
            .environmentObject(UserSettings.shared)
    
    }
}
