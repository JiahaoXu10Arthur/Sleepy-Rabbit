//
//  StartButtonView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct StartButtonView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var showOnboarding: Bool
    @Binding var bedHour: Int
    @Binding var bedMinute: Int
    @Binding var sleepHour: Int
    @Binding var sleepMinute: Int
    
    @State private var startHour = 0
    @State private var startMinute = 0
    
    var body: some View {
        Button(action: {
            showOnboarding = false
            modelData.chosenTasks = modelData.chosenTasks.filter { $0.title != "Sleep" }
            let sleep = Task(title: "Sleep", hour: sleepHour, minute: sleepMinute, startHour: bedHour, startMinute: bedMinute)
            startHour = bedHour
            startMinute = bedMinute
            
            var tasks: [Task] = [sleep]
            
            for task in modelData.chosenTasks {
                tasks.append(updateTask(task: task))
            }
            
            modelData.chosenTasks = tasks
        
        }) {
            HStack(spacing: 8) {
                Text("Start")
                
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(Color.white, lineWidth: 1.25)
            )
        } //: BUTTON
        
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
        return Task(title: task.title, hour: task.hour, minute: task.minute, startHour: startHour, startMinute: startMinute)
    }
 
    
    
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView(showOnboarding: .constant(true), bedHour: .constant(14), bedMinute: .constant(51), sleepHour: .constant(12), sleepMinute: .constant(21))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .environmentObject(ModelData.shared)
    
    }
}
