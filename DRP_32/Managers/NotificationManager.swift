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
import UserNotifications
import CoreLocation

class NotificationManager: ObservableObject {
  static let shared = NotificationManager()
  @Published var settings: UNNotificationSettings?
  
  func removeScheduledNotification(task: Tasked) {
    UNUserNotificationCenter.current()
      .removePendingNotificationRequests(withIdentifiers: [task.id])
  }
  
  func requestAuthorization(completion: @escaping  (Bool) -> Void) {
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in

        self.fetchNotificationSettings()

        completion(granted)
      }
  }

  func fetchNotificationSettings() {
    // 1
    UNUserNotificationCenter.current().getNotificationSettings { settings in
      // 2
      DispatchQueue.main.async {
        self.settings = settings
      }
    }
  }
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
  
  // 1
  func scheduleNotification(task: Tasked) {
    // 2
    let content = UNMutableNotificationContent()
    content.title = task.name
      
    let a = "Duration: \(task.hour) hours \(task.minute) minutes\n"
    let b = "@ \(_:formatTime(task.startHour)):\(_:formatTime(task.startMinute)) (\(task.before) minutes left)"
    
      content.body = a+b

    // 3
    var trigger: UNNotificationTrigger?
    switch task.reminder.reminderType {
      
    case .time:
      if let timeInterval = task.reminder.timeInterval {
        trigger = UNTimeIntervalNotificationTrigger(
          timeInterval: timeInterval,
          repeats: task.reminder.repeats)
      }
      
    case .calendar:
      if let date = task.reminder.date {
        trigger = UNCalendarNotificationTrigger(
          dateMatching: Calendar.current.dateComponents(
            [.day, .month, .year, .hour, .minute, .second],
            from: date),
          repeats: task.reminder.repeats)
      }
    default:
      return
    }

    // 4
    if let trigger = trigger {
      let request = UNNotificationRequest(
        identifier: task.id,
        content: content,
        trigger: trigger)
      // 5
      UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
          print(error)
        }
      }
    }
  }

}
