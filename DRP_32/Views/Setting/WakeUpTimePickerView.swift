//
//  WakeUpTimePickerView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct WakeUpTimePickerView: View {
    
    @Binding var wakeHour: Int
    @Binding var wakeMinute: Int
    
    static private let maxHours = 23
    static private let maxMinutes = 59
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...3).map { $0 * 15 }
    @EnvironmentObject var settings: UserSettings
    
    var bedHour: Int { settings.bedHour }
    var bedMinute: Int { settings.bedMinute }
    var sleepHour: Int { settings.sleepHour }
    var sleepMinute: Int { settings.sleepMinute }
    
    @State private var startHour = 0
    @State private var startMinute = 0
    
    
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
               
                Picker(selection: $wakeHour, label: Text("")) {
                    ForEach(hours, id: \.self) { value in
                        Text("\(formatTime(_:value))")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width * 25 / 51, alignment: .center)
                .labelsHidden()
                .onChange(of: wakeHour) { newValue in
                    update()
                }
                
                Text(":")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: geometry.size.width / 51, alignment: .center)
                
                Picker(selection: $wakeMinute, label: Text("")) {
                    ForEach(minutes, id: \.self) { value in
                        Text("\(formatTime(_:value))")
                            .tag(value)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width * 25 / 51, alignment: .center)
                .labelsHidden()
                .onChange(of: wakeMinute) { newValue in
                    update()
                }
            }
        }
    }
    
    func update() {
        settings.sleep = Task(title: "Sleep", hour: sleepHour, minute: sleepMinute, startHour: bedHour, startMinute: bedMinute, detail: settings.sleep.detail, referenceLinks: settings.sleep.referenceLinks, before: settings.sleep.before, type: settings.sleep.type)

        startHour = bedHour
        startMinute = bedMinute
        var tasks: [Task] = []
        
        for task in settings.bedTimeRoutine.reversed() {
            tasks.append(updateTask(task: task))
        }
        
        settings.bedTimeChosenTasks = tasks.reversed()
        settings.bedTimeRoutine = tasks.reversed()
        startHour = wakeHour
        startMinute = wakeMinute

        tasks = []
        
        for task in settings.wakeUpRoutine {
            tasks.append(updateTask2(task: task))
        }
        
        settings.wakeUpChosenTasks = tasks
        settings.wakeUpRoutine = tasks
        
        
        
        TaskAdaptor.shared.removeAll()
        tasks.append(settings.sleep)
        
        let notifications = tasks + settings.bedTimeChosenTasks
        for task in notifications {
            TaskAdaptor.shared.addNewTask(task: task)
        }
    }
    
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
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
        
        let task = Task(title: task.title, hour: task.hour, minute: task.minute, startHour: startHour, startMinute: startMinute, detail: task.detail, referenceLinks: task.referenceLinks, before: task.before, type: "Bedtime")
        
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
        let task = Task(title: task.title, hour: task.hour, minute: task.minute, startHour: startHour, startMinute: startMinute, detail: task.detail, referenceLinks: task.referenceLinks, before: task.before, type: "Wake Up")
        updateStart2(hour: task.hour, minute: task.minute)
        
        return task
    }
    
}

struct WakeUpTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        WakeUpTimePickerView(wakeHour: .constant(0), wakeMinute: .constant(0))

    }
}
