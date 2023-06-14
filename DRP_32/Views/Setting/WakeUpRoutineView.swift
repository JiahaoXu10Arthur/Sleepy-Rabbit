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
            Form{
                
                Section(header: Text(" a set of habits or motions that you go through when you wake up")) {
                    Text("Wake Up Time: \(formatTime(_:settings.wakeHour)) : \(formatTime(_:settings.wakeMinute))")
                    List {
                        ForEach(tasks) { task in
                            WakeUpTaskCell(task: task)
                        }
                        .onMove(perform: moveRow)
                        .onDelete(perform: deleteRow)
                    }
                }
            }
            .navigationTitle(Text("Wake Up Routine"))
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
            .sheet(isPresented: $isPresented) {
                NewTaskView(selectedType: "Wake Up", isPresented: $isPresented)
                    
            }
        }
        
        
    }
    
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
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
