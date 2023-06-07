//
//  TaskCellView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct TaskCellView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var task: Task
    
    @State var isChosen = false
    
    
    var body: some View {
        HStack {
            Image(systemName: isChosen ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(
                    isChosen ? .green : .gray)
                .onTapGesture {
                    isChosen = !isChosen
                    if isChosen {
                        modelData.chosenTasks.append(task)
                    } else {
                        if let index = modelData.chosenTasks.firstIndex(of: task) {
                            modelData.chosenTasks.remove(at: index)
                        }
                    }
                    print( "\(modelData.chosenTasks.first?.title)")
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                Text("\(task.hour)h \(task.minute)m")
                    .multilineTextAlignment(.leading)
               
            }
        }
    }
}

struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Task Title", hour: 12, minute: 30)
        
        TaskCellView(task: task)
            .environmentObject(ModelData.shared)
    }
}
