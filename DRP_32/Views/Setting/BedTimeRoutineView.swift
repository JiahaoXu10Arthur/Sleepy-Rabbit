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
    
    var body: some View {
        NavigationView {
            Form{
                
                Section(footer: Text("A bedtime routine is a set of activities you perform in the same order before going to bed.")) {
                    List {
                        ForEach(tasks) { task in
                            TaskCellView(task: task)
                            
                        }
                        
                        .onMove(perform: moveRow)
                        .onDelete(perform: deleteRow)
                    }
                }
                
            }
            
            .navigationTitle(Text("Bedtime Routine"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .font(.title3)
                
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title3)
                    
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
        .sheet(isPresented: $isPresented) {
            NewTaskView(selectedType: "Bedtime", isPresented: $isPresented)
                
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
