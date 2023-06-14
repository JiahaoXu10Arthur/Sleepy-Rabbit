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
    
    @Published var bedHour: Int = 0
    @Published var bedMinute: Int = 0
    @Published var sleepHour: Int = 0
    @Published var sleepMinute: Int = 0
    @Published var wakeHour: Int = 0
    @Published var wakeMinute: Int = 0
    
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
    
    @Published var showOnboarding: Bool {
        didSet {
            saveShow() 
        }
    }
    
    @Published var allowNotification: Bool {
        didSet {
            saveNotification()
        }
    }
    
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
        
        if let data3 = UserDefaults.standard.data(forKey: "showOnboarding"),
           let show = try? JSONDecoder().decode(Bool.self, from: data3) {
            showOnboarding = show
        } else {
            showOnboarding = true
        }
        
        if let data4 = UserDefaults.standard.data(forKey: "allowNotification"),
           let notification = try? JSONDecoder().decode(Bool.self, from: data4) {
            allowNotification = notification
        } else {
            allowNotification = false
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
    
    private func saveShow() {
        if let data = try? JSONEncoder().encode(showOnboarding) {
            UserDefaults.standard.set(data, forKey: "showOnboarding")
        }
    }
    
    private func saveNotification() {
        if let data = try? JSONEncoder().encode(allowNotification) {
            UserDefaults.standard.set(data, forKey: "allowNotification")
        }
    }

}
