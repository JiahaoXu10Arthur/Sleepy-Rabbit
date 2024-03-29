//
//  TimeLineView.swift
//  DRP_32
//
//  Created by paulodybala on 07/06/2023.
//

import SwiftUI

struct TimeLineView: View {
    @EnvironmentObject var settings: UserSettings
    var tasks: [Task] {
        settings.bedTimeChosenTasks
    }
    var tasks2: [Task] {
        settings.wakeUpChosenTasks
    }
    
    static private let maxHours = 24
    static private let maxMinutes = 60
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...Self.maxMinutes)
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    let hourHeight = 75.0
    let header = CGFloat(37)
    
    @State private var isSetting = false
    @State private var isAdding = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(hours, id: \.self) { hour in
                            HStack {
                                Text("\(formatTime(_:hour)) : 00")
                                    .font(.caption)
                                    .frame(width: 50, height: 20, alignment: .trailing)
                                Color.gray
                                    .frame(height: 1)
                            }.frame(height: hourHeight)
                        }
                    }
                    ForEach(tasks) { task in
                        if nextDay(task) {
                            sleepCell(task)
                        }
                        taskCell(task)
                    }
                    ForEach(tasks2) { task in
                        if nextDay(task) {
                            sleepCell(task)
                        }
                        taskCell(task)
                    }
                    if nextDay(settings.sleep) {
                        sleepCell(settings.sleep)
                    }
                    taskCell(settings.sleep)

                }
            }
            .padding()
            .navigationTitle(
                Text("Routine Timeline"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isAdding.toggle()
                    
                    }) {
                        Text("Add Task")
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isSetting.toggle()
                    }) {
                        Text("Settings")
                            .font(.title3)
                    }
                }
            }
            .fullScreenCover(isPresented: $isSetting) {
                SettingsView(isSetting: $isSetting)
            }
            .fullScreenCover(isPresented: $isAdding) {
                NewTaskView(selectedType: "Bedtime",isPresented: $isAdding)
            }
            
            
        
        }
      
    }
    
    func nextDay(_ task: Task) -> Bool {
        let duration = Double(task.hour) + Double(task.minute) / 60
        let hour = task.startHour
        let minute = task.startMinute
        let total = Double(hour) + (Double(minute) / 60) + duration
        return total > 24
    }
    
    func taskCell(_ task: Task) -> some View {
        var duration = Double(task.hour) + Double(task.minute) / 60
        let hour = task.startHour
        let minute = task.startMinute
        let total = Double(hour) + (Double(minute) / 60) + duration
        
        if total > 24 {
            var rest = duration
            duration = 24 - (Double(hour) + Double(minute) / 60)
            rest = rest - duration
            
        }
        
        let height = Double(duration) * hourHeight
        let offset = Double(hour) * (hourHeight)
        + Double(minute)/60 * hourHeight
        
        return
        NavigationLink(destination: CellDetailView(task: task)) {
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(formatTime(_:hour)):\(formatTime(_:minute))   \(task.hour)h \(task.minute)m")
                        .foregroundColor(Color.black)
                    
                    Text(task.title).foregroundColor(Color.black).bold()
                    Spacer()
                    
                    if task.type == "Bedtime" {
                        Image(systemName: "moon.haze.fill")
                            .foregroundColor(.purple)
                        
                    } else if task.type == "Sleep" {
                        Image(systemName: "moon.zzz.fill")
                            .foregroundColor(.blue)
                        
                    } else {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.yellow)
                        
                    }
                    
                
                    
                }
                
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(4)
            .frame(height: height, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.teal).opacity(0.5).border(.white, width: 1)
            )
        }
        .font(.caption)
        .offset(y: header)
        .padding(.trailing, 59)
        .offset(x: 57, y: offset)
        
    }
    func sleepCell(_ task: Task) -> some View {
        
        let hour = task.startHour
        let minute = task.startMinute
        let duration = Double(task.hour) + Double(task.minute) / 60 - (24 - (Double(hour) + Double(minute) / 60))
        
        let height = Double(duration) * hourHeight
        return
        NavigationLink(destination: CellDetailView(task: task)) {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(formatTime(_:hour)):\(formatTime(_:minute))   \(task.hour)h \(task.minute)m")
                        .font(.caption)
                        .foregroundColor(Color.black)
                    Text(task.title).foregroundColor(Color.black).bold()
                    Spacer()
                    
                        
                    if task.type == "Bedtime" {
                        Image(systemName: "moon.haze.fill")
                            .foregroundColor(.purple)
                        
                    } else if task.type == "Sleep" {
                        Image(systemName: "moon.zzz.fill")
                            .foregroundColor(.blue)
                        
                    } else {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.yellow)
                    }
                    
                    
                }
                
            }
            .font(.caption)
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(4)
            .frame(height: height, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.teal).opacity(0.5)
            )
        }
        .offset(y: header)
        .padding(.trailing, 59)
        .offset(x: 57, y: 0)
    }
    
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineView()
            .environmentObject(UserSettings.shared)
    }
}
