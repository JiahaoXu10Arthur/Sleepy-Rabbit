//
//  AddButtonVIew.swift
//  DRP_32
//
//  Created by paulodybala on 09/06/2023.
//

import SwiftUI

struct AddButtonVIew: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func addTask(title: String, hour: Int, minute: Int, startHour: Int, startMinute: Int, wakeUp: Bool) {
        let task = Task(title: title, hour: hour, minute: minute, startHour: startHour, startMinute: startMinute)
        if wakeUp {
            settings.wakeUpTasks.append(task)
        } else {
            settings.bedTimeTasks.append(task)
        }
    }
    
    
}

struct AddButtonVIew_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonVIew()
    }
}
