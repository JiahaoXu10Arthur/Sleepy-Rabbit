//
//  BedTimeSettingView.swift
//  DRP_32
//
//  Created by paulodybala on 05/06/2023.
//

import SwiftUI

struct BedTimeSettingView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    // Default time
    
    @AppStorage("sleepHour") var sleepHour = 0
    @AppStorage("sleepMinute") var sleepMinute = 15
    @AppStorage("wakeHour") var wakeHour = 0
    @AppStorage("wakeMinute") var wakeMinute = 0
    @AppStorage("bedHour") var bedHour = 0
    @AppStorage("bedMinute") var bedMinute = 0
    @State private var startHour = 0
    @State private var startMinute = 0
    
    private let hours = [Int](0...24)
    private let minutes = [Int](0...60)
    
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    
    var sleepingTime: String {
        var hour = wakeHour - sleepHour
        var minute = wakeMinute - sleepMinute
        if minute < 0 {
            minute = 60 + minute
            hour -= 1
        }
        if hour < 0 {
            hour = 24 + hour
        }
        bedHour = hour
        bedMinute = minute
        return "\(formatTime(_:bedHour)) : \(formatTime(_:bedMinute))"
    }
    
    /*
     View for the Bed Time Setting
     */
    var body: some View {
        NavigationView{
            
            Form {
                
                Section{
                    HStack {
                        ColoredIconView(imageName: "sun.and.horizon", foregroundColor: .white, backgroundColor: .orange)
                            .font(.title)
                        Text("Wake Up Time")
                            .font(.title)
                            .padding(.leading)
                    }
                    WakeUpTimePickerView(wakeHour: $wakeHour, wakeMinute: $wakeMinute)
                        .frame(height: 120.0)
                }
                Section(footer: Text("Suggested sleep duration: 7-9 hours per night")){
                    
                    HStack {
                        ColoredIconView(imageName: "moon.zzz", foregroundColor: .white, backgroundColor: .purple)
                            .font(.largeTitle)
                        Text("Sleeping Duration")
                            .font(.title)
                            .padding(.leading)
                    }
                   
                    VStack {
                        CustomDatePicker(sleepHour: $sleepHour, sleepMinute: $sleepMinute)
                            .frame(height: 120.0)
                        if sleepHour * 60 + sleepMinute < 15 {
                            Text("Sleep duration should be at least 15 minutes")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.top, 10)
                        }
                    }
                }
                Section(header: Text("Automatic Calculated")){
                    HStack {
                        ColoredIconView(imageName: "bed.double", foregroundColor: .white, backgroundColor: .blue)
                            .font(.title)
                        
                        
                        VStack {
                            Text("\(sleepingTime)")
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.center)
                            Text("Go to bed at")
                                .font(.callout)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.leading)
                        
                    }
                    
                }
                
                
            }
            .navigationTitle(Text("Sleep Time Setting")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.black))
            
            .navigationBarTitleDisplayMode(.large)
            .navigationViewStyle(StackNavigationViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                update()
            }
            .onDisappear {
                DispatchQueue.main.async {
                    settings.bedHour = bedHour
                    settings.bedMinute = bedMinute
                    settings.sleepHour = sleepHour
                    settings.sleepMinute = sleepMinute
                    settings.wakeHour = wakeHour
                    settings.wakeMinute = wakeMinute
                }
                update()
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
        
        TaskAdaptor.shared.removeAll()
        tasks.append(settings.sleep)
        
        let notifications = tasks + settings.bedTimeChosenTasks
        for task in notifications {
            TaskAdaptor.shared.addNewTask(task: task)
        }
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

struct BedTimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BedTimeSettingView()
            .environmentObject(UserSettings.shared)
    }
}
