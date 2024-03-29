/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

class TaskAdaptor {
  static let shared = TaskAdaptor()
  
    func addNewTask(task: Task) {
        let date = Calendar.current.date(bySettingHour: task.startHour, minute: task.startMinute, second: 0, of: Date())
        
        if let date = date {
            let d = Calendar.current.date(byAdding: .minute, value: -(task.before), to: date)
            
            let reminder = Reminder(date: d, reminderType: .calendar, repeats: true)
            let t = Tasked(id: task.id.uuidString, name: task.title, reminderEnabled: true, reminder: reminder, hour: task.hour, minute: task.minute, startHour: task.startHour, startMinute: task.startMinute, before: task.before)
            TaskManager.shared.save(task: t)
        }
    }
  
  func remove(task: Task) {
      let t = Tasked(id: task.id.uuidString, name: task.title, reminderEnabled: true, reminder: Reminder(), hour: task.startHour, minute: task.startMinute, startHour: task.startHour, startMinute: task.startMinute, before: task.before)
    TaskManager.shared.remove(task: t)
  }
    func removeAll() {
       TaskManager.shared.tasks.forEach{ task in
         TaskManager.shared.remove(task: task)
       }
     }
}

class TaskManager: ObservableObject {
  static let shared = TaskManager()                     // An instance
  let taskPersistenceManager = TaskPersistenceManager()

  @Published var tasks: [Tasked] = []

  init() {
    loadTasks()
  }

  func save(task: Tasked) {
    tasks.append(task)
    DispatchQueue.global().async {
      self.taskPersistenceManager.save(tasks: self.tasks)
    }
    
    if task.reminderEnabled {
      NotificationManager.shared.scheduleNotification(task: task)
    }
  }

  func loadTasks() {
    self.tasks = taskPersistenceManager.loadTasks()
  }
    
  func remove(task: Tasked) {
    tasks.removeAll {
      $0.id == task.id
    }
    DispatchQueue.global().async {
      self.taskPersistenceManager.save(tasks: self.tasks)
    }
    
    if task.reminderEnabled {
      NotificationManager.shared.removeScheduledNotification(task: task)
    }
  }

  func markTaskComplete(task: Tasked) {
    if let row = tasks.firstIndex(where: { $0.id == task.id }) {
      var updatedTask = task
      updatedTask.completed = true
      tasks[row] = updatedTask
    }
  }
}
