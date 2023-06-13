//
//  NewTaskButton.swift
//  DRP_32
//
//  Created by paulodybala on 12/06/2023.
//

import SwiftUI

struct NewTaskButton: View {
    @EnvironmentObject var settings: UserSettings
    
    @Binding var title: String
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var startHour: Int
    @Binding var startMinute: Int
    
    @Binding var isAutomatic: Bool
    
    @Binding var selectedType: String
    
    @Binding var detail: String
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button (action: {
            let task = Task(title: title, hour: hour, minute: minute, startHour: startHour, startMinute: startMinute, detail: detail)
            if selectedType == "BedTime" {
                settings.bedTimeChosenTasks.append(task)
            } else {
                settings.wakeUpChosenTasks.append(task)
            }
            isPresented.toggle()
        
        }) {
            HStack(spacing: 8) {
                Text("Save")
            }
            .padding(.vertical, 10)
        }

        
    }
}

struct NewTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskButton(title: .constant("Test"), hour: .constant(0), minute: .constant(0), startHour: .constant(-1), startMinute: .constant(-1), isAutomatic: .constant(true), selectedType: .constant("BedTime"), detail: .constant("Test"), isPresented: .constant(true))
            .environmentObject(UserSettings.shared)
    
    }
}
