//
//  BedTimeRoutineView.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import SwiftUI

struct BedTimeRoutineView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var editMode = EditMode.inactive
    var tasks: [Task] {
        settings.bedTimeRoutine
    }
    @State var isPresented = false
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
        NavigationView {
            Form{
                
                Section(header: Text("a set of activities you perform in the same order before going to bed.")
                    .foregroundColor(.primary)
                    , footer:  HStack {
                    Text("New Task will be added here")
                    Image(systemName: "arrow.up")
                
                }.font(.title2)) {
                    List {
                        ForEach(tasks) { task in
                            TaskCellView(task: task)
                        }
                        
                        .onMove(perform: moveRow)
                        .onDelete(perform: deleteRow)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Go to bed at")
                        Text("\(formatTime(_:settings.bedHour)) : \(formatTime(_:settings.bedMinute))")
                            .font(.headline)
                    }
                    
                }
                
            }
            
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(.spring(), value: isEditing)
            .navigationTitle(Text("Bedtime Routine"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isEditing.toggle()
                    }) {
                        Text(isEditing ? "Done" : "Edit")
                            .font(.title3)
                    }
                    .font(.title3)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        HStack {
                            Text("Add Task")
                        }
                        .font(.title3)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        settings.bedTimeRoutine.shuffle()
                        update()
                    }){
                        Text("Automatic Orderding")
                    }
                }
            }
            
        }
        .sheet(isPresented: $isPresented) {
            SecondNewTaskView(selectedType: "Bedtime", isPresented: $isPresented)
        }
    }
    
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    private func deleteRow(at indexSet: IndexSet) {
        settings.bedTimeRoutine.remove(atOffsets: indexSet)
        update()
    }
    
    
    private func moveRow(source: IndexSet, destination: Int){
        settings.bedTimeRoutine.move(fromOffsets: source,           toOffset: destination)
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

struct BedTimeRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        BedTimeRoutineView()
            .environmentObject(UserSettings.shared)
    }
}
