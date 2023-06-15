//
//  EditDetailButtonView.swift
//  DRP_32
//
//  Created by paulodybala on 15/06/2023.
//

import SwiftUI

struct EditDetailButtonView: View {
    @EnvironmentObject var settings: UserSettings
    
    @Binding var title: String
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var taskHour: Int
    @Binding var taskMinute: Int
    
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
    
    @Binding var errorMessage: String
    @Binding var shouldShowValidationAlert: Bool
    @Binding var referenceLinks: [(String, Bool)]
    
    @State private var urls: [String] = []
    @Binding var notify: String
    @State private var before = 5
    @Binding var task: Task
    var original: Task
    
    let befores = ["At time of event", "5 minutes before", "10 minutes before", "15 minutes before", "20 minutes before", "30 minutes before", "1 hour before"]

    
    var body: some View {
        Button (action: {
            if title.isEmpty {
                errorMessage = "Task Title Required"
                shouldShowValidationAlert.toggle()
            } else if hour * 60 + minute < 15 {
                errorMessage = "Task Duration Should Be Longer Than 15 Minutes"
                shouldShowValidationAlert.toggle()
            } else {
                createNewReference()
                generateBefore()
                if original.type == task.type {
                    if original.type == "Bedtime" {
                        if let index = settings.bedTimeRoutine.firstIndex(of: original) {
                            settings.bedTimeRoutine[index] = task
                            settings.bedTimeRoutine[index] = task
                        }
                    } else {
                        if let index = settings.wakeUpRoutine.firstIndex(of: original) {
                            settings.wakeUpRoutine[index] = task
                            settings.wakeUpChosenTasks[index] = task
                        }
                    }
                
                } else {
                    let task1 = Task(title: title, hour: hour, minute: minute, startHour: taskHour, startMinute: taskMinute, detail: detail, referenceLinks: urls, before: before,type: selectedType)
                    task = task1
                    if selectedType == "Bedtime" {
                        print(original)
                        print(task)
                        print(selectedType)
                        if let index = settings.wakeUpRoutine.firstIndex(of: original) {
                            settings.wakeUpRoutine.remove(at: index)
                            settings.wakeUpChosenTasks.remove(at: index)
                        
                        }
                        settings.bedTimeRoutine.append(task1)
                        settings.bedTimeRoutine.append(task1)
                    } else {
                        print(original)
                        print(task)
                        print(selectedType)
                        if let index = settings.bedTimeRoutine.firstIndex(of: original) {
                            settings.bedTimeRoutine.remove(at: index)
                            settings.bedTimeRoutine.remove(at: index)
                        }
                        
                        settings.wakeUpRoutine.append(task1)
                        settings.wakeUpChosenTasks.append(task1)
                    }
                }
                
               
                isPresented.toggle()
                update()
            }
        }) {
            HStack(spacing: 8) {
                Text("Save")
            }
            .padding(.vertical, 10)
        }

        
    }
    
    func canOpenURL(_ string: String?) -> Bool {
        var formatterString = string?.trimmingCharacters(in: .whitespacesAndNewlines)
        formatterString = formatterString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = formatterString, let url = URL(string: urlString) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func createNewReference() {
        for link in referenceLinks where canOpenURL(link.0) {
            urls.append(link.0)
        }
    }
    
    func generateBefore() {
        switch notify {
        case "At time of event":
            before = 0
        case "5 minutes before":
            before = 5
        case "10 minutes before":
            before = 10
        case "15 minutes before":
            before = 15
        case "20 minutes before":
            before = 20
        case "30 minutes before":
            before = 30
        case "1 hour before":
            before = 60
        default:
            before = 5
        }
    }
    
    
    func update() {
        settings.bedTimeRoutine = settings.bedTimeRoutine.filter { $0.title != "Sleep"}
        
        let sleep = Task(title: "Sleep", hour: sleepHour, minute: sleepMinute, startHour: bedHour, startMinute: bedMinute, type: "Bedtime")
        startHour = bedHour
        startMinute = bedMinute
        var tasks: [Task] = [sleep]
        
        for task in settings.bedTimeRoutine.reversed() {
            tasks.append(updateTask(task: task))
        }
        
        settings.bedTimeRoutine = tasks
        
        startHour = wakeHour
        startMinute = wakeMinute
        
       
        
        tasks = []
        
        for task in settings.wakeUpRoutine {
            tasks.append(updateTask2(task: task))
        }
        
        settings.wakeUpChosenTasks = tasks
        
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
        let task = Task(title: task.title, hour: task.hour, minute: task.minute, startHour: startHour, startMinute: startMinute, detail: task.detail, referenceLinks: task.referenceLinks, type: "Wake Up")
        updateStart2(hour: task.hour, minute: task.minute)
        
        return task
    }
}

struct EditDetailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Take a Warm Bath", hour: 0, minute: 30, startHour: 21, startMinute: 30, detail: "This is detail", referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime")
        EditDetailButtonView(title: .constant("Test"), hour: .constant(0), minute: .constant(0), taskHour: .constant(-1), taskMinute: .constant(-1), selectedType: .constant("BedTime"), detail: .constant("Test"), isPresented: .constant(true), errorMessage: .constant("Test"), shouldShowValidationAlert: .constant(true), referenceLinks: .constant([]), notify: .constant(""), task: .constant(task), original: task)
            .environmentObject(UserSettings.shared)
    }
}
