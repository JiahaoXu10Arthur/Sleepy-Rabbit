//
//  UserSettings.swift
//  DRP_32
//
//  Created by paulodybala on 08/06/2023.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    static let shared = UserSettings()
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var bedHour = 0
    @Published var bedMinute = 0
    @Published var sleepHour = 0
    @Published var sleepMinute = 0
    @Published var wakeHour = 0
    @Published var wakeMinute = 0
    
    @Published var tasks: [Task] = [Task(title: "Take a Warm Bath", hour: 0, minute: 30), Task(title: "Listen to Music", hour: 1, minute: 0), Task(title: "Stretch", hour: 0, minute: 15), Task(title: "Breathe", hour: 0, minute: 30), Task(title: "Practice Meditation", hour: 1, minute: 30), Task(title: "Read a Book", hour: 2, minute: 0), Task(title: "Write Down a To-Do List", hour: 0, minute: 20)]
    @Published var chosenTasks: [Task] {
        didSet {
                   saveTasks()
               }
    }
    
    @Published var wakeUpTasks: [Task] {
        didSet {
            saveTasks2()
        }
    }
    
    @Published var showOnboarding: Bool = true
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        if let data = UserDefaults.standard.data(forKey: "chosenTasks"),
           let tasks = try? JSONDecoder().decode([Task].self, from: data) {
            chosenTasks = tasks
        } else {
            chosenTasks = []
        }
        
        if let data2 = UserDefaults.standard.data(forKey: "wakeUpTasks"),
           let tasks2 = try? JSONDecoder().decode([Task].self, from: data2) {
            wakeUpTasks = tasks2
        } else {
            wakeUpTasks = []
        }
        
    }
    private func saveTasks() {
            if let data = try? JSONEncoder().encode(chosenTasks) {
                UserDefaults.standard.set(data, forKey: "chosenTasks")
            }
        }
    private func saveTasks2() {
        if let data = try? JSONEncoder().encode(wakeUpTasks) {
            UserDefaults.standard.set(data, forKey: "wakeUpTasks")
        }
    }

}
