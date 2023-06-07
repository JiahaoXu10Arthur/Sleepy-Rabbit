//
//  TaskListView.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Environment(\.dismiss) private var dismiss
    
    var tasks: [Task] {
        modelData.tasks
    }
       
    var body: some View {
        
        NavigationView {
            List {
                ForEach(tasks) { task in
                    TaskCellView(task: task)
                }
            }
        
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                        
                        
                        modelData.chosenTasks = []
                        
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Select Your Routine")
        }
       
    }
        
        
    
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        
        TaskListView()
            .environmentObject(ModelData.shared)
    }
}
