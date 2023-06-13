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
    
    @Published var bedTimeRoutine: [Task] = [Task(title: "Take a Warm Bath", hour: 0, minute: 30), Task(title: "Listen to Music", hour: 1, minute: 0), Task(title: "Stretch", hour: 0, minute: 15), Task(title: "Breathe", hour: 0, minute: 30), Task(title: "Practice Meditation", hour: 1, minute: 30), Task(title: "Read a Book", hour: 2, minute: 0), Task(title: "Write Down a To-Do List", hour: 0, minute: 20)]
    
    @Published var wakeUpRoutine: [Task] = [Task(title: "Take a Warm Bath", hour: 0, minute: 30), Task(title: "Listen to Music", hour: 1, minute: 0), Task(title: "Stretch", hour: 0, minute: 15), Task(title: "Breathe", hour: 0, minute: 30), Task(title: "Practice Meditation", hour: 1, minute: 30), Task(title: "Read a Book", hour: 2, minute: 0), Task(title: "Write Down a To-Do List", hour: 0, minute: 20)]
    
    @Published var bedTimeTasks: [Task] = [Task(title: "Take a Warm Bath", hour: 0, minute: 30), Task(title: "Listen to Music", hour: 1, minute: 0), Task(title: "Stretch", hour: 0, minute: 15), Task(title: "Breathe", hour: 0, minute: 30), Task(title: "Practice Meditation", hour: 1, minute: 30), Task(title: "Read a Book", hour: 2, minute: 0), Task(title: "Write Down a To-Do List", hour: 0, minute: 20)]
    @Published var wakeUpTasks: [Task] = [Task(title: "Take a Warm Bath", hour: 0, minute: 30), Task(title: "Listen to Music", hour: 1, minute: 0), Task(title: "Stretch", hour: 0, minute: 15), Task(title: "Breathe", hour: 0, minute: 30), Task(title: "Practice Meditation", hour: 1, minute: 30), Task(title: "Read a Book", hour: 2, minute: 0), Task(title: "Write Down a To-Do List", hour: 0, minute: 20)]
    
    @Published var bedTimeChosenTasks: [Task] {
        didSet {
                   saveTasks()
               }
    }
    
    @Published var wakeUpChosenTasks: [Task] {
        didSet {
            saveTasks2()
        }
    }
    
    @Published var showOnboarding: Bool = true
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        if let data = UserDefaults.standard.data(forKey: "chosenTasks"),
           let tasks = try? JSONDecoder().decode([Task].self, from: data) {
            bedTimeChosenTasks = tasks
        } else {
            bedTimeChosenTasks = []
        }
        
        if let data2 = UserDefaults.standard.data(forKey: "wakeUpTasks"),
           let tasks2 = try? JSONDecoder().decode([Task].self, from: data2) {
            wakeUpChosenTasks = tasks2
        } else {
            wakeUpChosenTasks = []
        }
        
    }
    private func saveTasks() {
            if let data = try? JSONEncoder().encode(bedTimeChosenTasks) {
                UserDefaults.standard.set(data, forKey: "chosenTasks")
            }
        }
    private func saveTasks2() {
        if let data = try? JSONEncoder().encode(wakeUpChosenTasks) {
            UserDefaults.standard.set(data, forKey: "wakeUpTasks")
        }
    }

}
