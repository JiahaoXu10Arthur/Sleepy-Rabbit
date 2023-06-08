//
//  Try.swift
//  DRP_32
//
//  Created by paulodybala on 07/06/2023.
//

import SwiftUI

struct Try: View {
    @State var showNotificationSettingsUI = false
      
        var body: some View {
          VStack(alignment: .leading) {
            
            Button(action: {
              var reminder = Reminder()
              
              reminder.reminderType = .calendar
              
              reminder.date = Date(timeIntervalSinceNow: 5)
              
              TaskManager.shared.addNewTask("I know nothing",
                                            reminder)
            }) {
              Text("Give you a notificaiton after 5 seconds")
            }
            
            Button(action: {
              for task in TaskManager.shared.tasks {
                TaskManager.shared.remove(task: task)
              }
              
            }) {
              Text("Clean them all")
            }
            
            TaskListView()
          }
        }

}

struct Try_Previews: PreviewProvider {
    static var previews: some View {
        Try()
    }
}
