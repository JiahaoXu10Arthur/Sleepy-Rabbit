//
//  WakeUpRoutineView.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import SwiftUI

struct WakeUpRoutineView: View {
    @EnvironmentObject var settings: UserSettings
    var tasks: [Task] {
        settings.wakeUpRoutine
    }
    @State var isPresented = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(tasks) { task in
                    WakeUpTaskCell(task: task)
                }
                .onMove(perform: moveRow)
                .onDelete(perform: deleteRow)
            }
            .navigationTitle(Text("Wake Up Routine"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                NewTaskView(isPresented: $isPresented)
            }
        }
        
        
    }
    private func deleteRow(at indexSet: IndexSet) {
        settings.wakeUpRoutine.remove(atOffsets: indexSet)
    }
    
    
    private func moveRow(source: IndexSet, destination: Int){
        settings.wakeUpRoutine.move(fromOffsets: source,           toOffset: destination)
    }
    
}

struct WakeUpRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        WakeUpRoutineView()
            .environmentObject(UserSettings.shared)
    }
}
