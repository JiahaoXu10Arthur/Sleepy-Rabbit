//
//  TimeLineView.swift
//  DRP_32
//
//  Created by paulodybala on 07/06/2023.
//

import SwiftUI

struct TimeLineView: View {
    static private let maxHours = 24
    static private let maxMinutes = 60
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...Self.maxMinutes)
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    let cTasks: [Task] = [Task(title: "Task 1", hour: 1, minute: 30, startHour: 3, startMinute: 21), Task(title: "Task 2", hour: 0, minute: 5, startHour: 10, startMinute: 55), Task(title: "Task 3", hour: 3, minute: 51, startHour: 22, startMinute: 30)]
    let hourHeight = 50.0
    
    var body: some View {
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
                ForEach(cTasks) { task in
                    if nextDay(task) {
                        sleepCell(task)
                    }
                    taskCell(task)
                }
            }
        }
        .padding()
    }
    
    func nextDay(_ task: Task) -> Bool {
        var duration = Double(task.hour) + Double(task.minute) / 60
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
        
        

        return VStack(alignment: .leading) {
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    Text("\(formatTime(_:hour)):\(formatTime(_:minute))   \(task.hour)h \(task.minute)m")
                        .font(.caption)
                    Text(task.title).bold()
                }
                .font(.caption)
                Text("")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    .frame(height: height, alignment: .top)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.teal).opacity(0.5)
                        )
                    .offset(y: 26)
            }
            
            
        }
        .padding(.trailing, 60)
        .offset(x: 56, y: offset)
    }
    func sleepCell(_ task: Task) -> some View {
        
        let hour = task.startHour
        let minute = task.startMinute
        let duration = Double(task.hour) + Double(task.minute) / 60 - (24 - (Double(hour) + Double(minute) / 60))
        
        let height = Double(duration) * hourHeight
        return VStack(alignment: .leading) {
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    Text("\(formatTime(_:hour)):\(formatTime(_:minute))   \(task.hour)h \(task.minute)m")
                        .font(.caption)
                    Text(task.title).bold()
                }
                .font(.caption)
                Text("")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    .frame(height: height, alignment: .top)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.teal).opacity(0.5)
                        )
                    .offset(y: 26)
            }
            
            
        }
        .padding(.trailing, 60)
        .offset(x: 56, y: 0)
    
    }
    
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineView()
    }
}
