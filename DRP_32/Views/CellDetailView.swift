//
//  CellDetailView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct CellDetailView: View {
    @EnvironmentObject var settings: UserSettings
    @State var task: Task
    @State var isPresented = false
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.largeTitle)
                
                HStack {
                    if task.type == "Bedtime" {
                        Image(systemName: "moon.haze.fill")
                            .foregroundColor(.purple)
                        Text("\(task.type) Routine")
                    } else if task.type == "Sleep" {
                        Image(systemName: "moon.zzz.fill")
                            .foregroundColor(.blue)
                        Text("Sleep")
                    } else {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.orange)
                        Text("\(task.type) Routine")
                    }
                }
                .font(.subheadline)
                
                Spacer()
                
                Divider()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Duration:\n\(task.hour)hr \(task.minute)min")
                        
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    
                    if task.startHour > -1 {
                        HStack {
                            Text("\(formatTime(_:task.startHour)):\(formatTime(_:task.startMinute))")
                            Text(" - ")
                            createTime()
                        }
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    }
                }
                
                
                Divider()
                
                HStack {
                    Text("Remind me:")
                        .font(.title2)
                    Spacer()
                    Text("")
                    Text(generateBefore())
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                if task.referenceLinks.count > 0 {
                    Text("Reference Links:")
                        .font(.title2)
  
                    ForEach(task.referenceLinks, id: \.self) { link in
                        Link(destination: URL(string: link)!) {
                            Text(link)
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                        
                    }
                    Divider()
                }
                
                
                if task.detail != "" {
                    Text("Detail:")
                        .font(.title2)
                    Text(task.detail)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Divider()
                }
                
                
            }
            .padding()
        }
        .navigationTitle("Task Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresented.toggle()
                    
                }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            EditCellDetail(task: task, isPresented: $isPresented)
        }
        
    }
    
    
    func generateBefore() -> String{
        switch task.before {
        case 0:
            return "At time of event"
        case 5:
            return "5 minutes before"
        case 10:
            return "10 minutes before"
        case 15:
            return "15 minutes before"
        case 20:
            return "20 minutes before"
        case 30:
            return "30 minutes before"
        case 60:
            return "1 hour before"
        default:
            return "5 minutes before"
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

struct CellDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Take a Warm Bath", hour: 0, minute: 30, startHour: 21, startMinute: 30, detail: "adisdetailsjkdsafkkkklhhgkjsadgkjasjglaskjdlgkfasdjklajgdkalsdjkgsajdlksdjglkajdslgjaslkj", referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime")
        CellDetailView(task: task)
            .environmentObject(UserSettings.shared)
    }
}
