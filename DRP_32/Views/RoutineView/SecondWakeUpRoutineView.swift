//
//  SecondWakeUpRoutineView.swift
//  DRP_32
//
//  Created by paulodybala on 15/06/2023.
//

import SwiftUI

struct SecondWakeUpRoutineView: View {
    @EnvironmentObject var settings: UserSettings
    var tasks: [Task] {
        settings.wakeUpRoutine
    }
    @Binding var isPresented: Bool
    @State var isEditing = false
    
    var bedHour: Int { settings.bedHour }
    var bedMinute: Int { settings.bedMinute }
    var sleepHour: Int { settings.sleepHour }
    var sleepMinute: Int { settings.sleepMinute }
    var wakeHour: Int { settings.wakeHour }
    var wakeMinute: Int { settings.wakeMinute }
 
    @State private var startHour = 0
    @State private var startMinute = 0
    
    var body: some View {
        NavigationView{
            Form{
                
                Section(header: Text(" a set of habits or motions that you go through when you wake up").foregroundColor(.primary)
                        , footer:  HStack {
                    Text("New Task will be added here")
                    Image(systemName: "arrow.up")
                
                }.font(.title2)) {
                    VStack(alignment: .leading) {
                        Text("Go to bed at")
                        Text("\(formatTime(_:settings.wakeHour)) : \(formatTime(_:settings.wakeMinute))")
                            .font(.headline)
                    }
                    List {
                        ForEach(tasks) { task in
                            TaskCellView(task: task)
                        }
                        .onMove(perform: moveRow)
                        .onDelete(perform: deleteRow)
                    }
                }
            }
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(.spring(), value: isEditing)
            .navigationTitle(Text("Wake Up Routine"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isEditing.toggle()
                    }) {
                        Text(isEditing ? "Done" : "Edit")
                    }
                    .font(.title3)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    DoneButton(isSetting: $isPresented)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        settings.wakeUpRoutine.shuffle()
                        update()
                    }){
                        Text("Automatic Orderding")
                    }
                }
            }
        }
        
        
    }
    
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    private func deleteRow(at indexSet: IndexSet) {
        settings.wakeUpRoutine.remove(atOffsets: indexSet)
        update()
    }
    
    
    private func moveRow(source: IndexSet, destination: Int){
        settings.wakeUpRoutine.move(fromOffsets: source,           toOffset: destination)
        update()
    }
    
    func update() {
        settings.sleep = Task(title: "Sleep", hour: sleepHour, minute: sleepMinute, startHour: bedHour, startMinute: bedMinute, detail: settings.sleep.detail, referenceLinks: settings.sleep.referenceLinks, before: settings.sleep.before, type: settings.sleep.type)

        startHour = bedHour
        startMinute = bedMinute
        var tasks: [Task] = []
        
        for task in settings.bedTimeRoutine.reversed() {
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

struct SecondWakeUpRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        SecondWakeUpRoutineView(isPresented: .constant(true))
            .environmentObject(UserSettings.shared)
    
    }
}
