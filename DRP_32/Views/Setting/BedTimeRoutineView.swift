//
//  BedTimeRoutineView.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import SwiftUI

struct BedTimeRoutineView: View {
    @EnvironmentObject var settings: UserSettings
    var tasks: [Task] {
        settings.bedTimeRoutine
    }
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    TaskCellView(task: task)
                }
                .onMove(perform: moveRow)
                .onDelete(perform: deleteRow)
            }
            
            .navigationTitle(Text("BedTime Routine"))
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
        }
        .sheet(isPresented: $isPresented) {
            NewTaskView(isPresented: $isPresented)
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        settings.bedTimeRoutine.remove(atOffsets: indexSet)
    }
    
    
    private func moveRow(source: IndexSet, destination: Int){
        settings.bedTimeRoutine.move(fromOffsets: source,           toOffset: destination)
    }
}

struct BedTimeRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        BedTimeRoutineView()
            .environmentObject(UserSettings.shared)
    }
}
