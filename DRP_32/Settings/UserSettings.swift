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
    
    @Published var bedTimeRoutine: [Task] {
        didSet {
            saveBedTimeRoutine()
        }
    }
    
    @Published var wakeUpRoutine: [Task] {
        didSet {
            saveWakeUpRoutine()
        }
    }
    @Published var bedTimeTasks: [Task] {
        didSet {
            saveBedTimeTasks()
        }
    }
    @Published var wakeUpTasks: [Task] {
        didSet {
            saveWakeUpTasks()
        }
    }
    
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
        
        if let data5 = UserDefaults.standard.data(forKey: "wakeUpTasks"),
           let tasks5 = try? JSONDecoder().decode([Task].self, from: data5) {
            wakeUpTasks = tasks5
        } else {
            wakeUpTasks = [Task(title: "Take a Warm Bath", hour: 0, minute: 30, type: "Wake Up"), Task(title: "Listen to Music", hour: 1, minute: 0, type: "Wake Up"), Task(title: "Stretch", hour: 0, minute: 15, type: "Wake Up"), Task(title: "Breathe", hour: 0, minute: 30, type: "Wake Up"), Task(title: "Practice Meditation", hour: 1, minute: 30, type: "Wake Up"), Task(title: "Read a Book", hour: 2, minute: 0, type: "Wake Up"), Task(title: "Write Down a To-Do List", hour: 0, minute: 20, type: "Wake Up")]
        }
        
        if let data6 = UserDefaults.standard.data(forKey: "bedTimeTasks"),
           let tasks6 = try? JSONDecoder().decode([Task].self, from: data6) {
            bedTimeTasks = tasks6
        } else {
            bedTimeTasks = [Task(title: "Take a Warm Bath", hour: 0, minute: 30, type: "Bedtime"), Task(title: "Listen to Music", hour: 1, minute: 0, type: "Bedtime"), Task(title: "Stretch", hour: 0, minute: 15, type: "Bedtime"), Task(title: "Breathe", hour: 0, minute: 30, type: "Bedtime"), Task(title: "Practice Meditation", hour: 1, minute: 30, type: "Bedtime"), Task(title: "Read a Book", hour: 2, minute: 0), Task(title: "Write Down a To-Do List", hour: 0, minute: 20, type: "Bedtime")]
        }
        
        if let data7 = UserDefaults.standard.data(forKey: "wakeUpRoutine"),
           let tasks7 = try? JSONDecoder().decode([Task].self, from: data7) {
            wakeUpRoutine = tasks7
        } else {
            wakeUpRoutine = [Task(title: "Take a Warm Bath", hour: 0, minute: 30, type: "Wake Up"), Task(title: "Listen to Music", hour: 1, minute: 0, type: "Wake Up"), Task(title: "Stretch", hour: 0, minute: 15, type: "Wake Up"), Task(title: "Breathe", hour: 0, minute: 30, type: "Wake Up"), Task(title: "Practice Meditation", hour: 1, minute: 30, type: "Wake Up"), Task(title: "Read a Book", hour: 2, minute: 0, type: "Wake Up"), Task(title: "Write Down a To-Do List", hour: 0, minute: 20, type: "Wake Up")]
        }
        
        if let data8 = UserDefaults.standard.data(forKey: "bedTimeRoutine"),
           let tasks8 = try? JSONDecoder().decode([Task].self, from: data8) {
            bedTimeRoutine = tasks8
        } else {
            bedTimeRoutine = [Task(title: "Take a Warm Bath", hour: 0, minute: 30, type: "Bedtime"), Task(title: "Listen to Music", hour: 1, minute: 0, type: "Bedtime"), Task(title: "Stretch", hour: 0, minute: 15, type: "Bedtime"), Task(title: "Breathe", hour: 0, minute: 30, type: "Bedtime"), Task(title: "Practice Meditation", hour: 1, minute: 30, type: "Bedtime"), Task(title: "Read a Book", hour: 2, minute: 0), Task(title: "Write Down a To-Do List", hour: 0, minute: 20, type: "Bedtime")]
        }
    
        
    }
    
    private func saveBedTimeRoutine() {
        if let data = try? JSONEncoder().encode(bedTimeRoutine) {
            UserDefaults.standard.set(data, forKey: "bedTimeRoutine")
        }
    }
    
    private func saveWakeUpRoutine() {
        if let data = try? JSONEncoder().encode(wakeUpRoutine) {
            UserDefaults.standard.set(data, forKey: "wakeUpRoutine")
        }
    }
    
    private func saveBedTimeTasks() {
        if let data = try? JSONEncoder().encode(bedTimeTasks) {
            UserDefaults.standard.set(data, forKey: "bedTimeTasks")
        }
    }
    
    
    private func saveWakeUpTasks() {
        if let data = try? JSONEncoder().encode(wakeUpTasks) {
            UserDefaults.standard.set(data, forKey: "wakeUpTasks")
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
