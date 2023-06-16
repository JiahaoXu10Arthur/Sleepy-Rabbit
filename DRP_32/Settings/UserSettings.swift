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
    
    @Published var bedHour: Int = 0 {
        didSet {
            UserDefaults.standard.set(bedHour, forKey: "bedHour")
        }
    }
    
    @Published var bedMinute: Int = 0 {
        didSet {
            UserDefaults.standard.set(bedMinute, forKey: "bedMinute")
        }
    }
    
    @Published var sleepHour: Int = 0 {
        didSet {
            UserDefaults.standard.set(sleepHour, forKey: "sleepHour")
        }
    }
    
    @Published var sleepMinute: Int = 15 {
        didSet {
            UserDefaults.standard.set(sleepMinute, forKey: "sleepMinute")
        }
    }
    
    @Published var wakeHour: Int = 0 {
        didSet {
            UserDefaults.standard.set(wakeHour, forKey: "wakeHour")
        }
    }
    @Published var wakeMinute: Int = 0 {
        didSet {
            UserDefaults.standard.set(wakeMinute, forKey: "wakeMinute")
        }
    }
    
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
    
    @Published var sleep: Task {
        didSet {
           saveSleep()
        }
    }
    @Published var universites: [String] = ["Imperial College London", "University of Cambridge", "University of Oxford", "University College London", "London School of Economics and Political Science", "University of Edinburgh", "King's College London", "University of Manchester", "University of Bristol", "University of Warwick", "University of Glasgow"]
    
    @Published var chosenUniversity: String = "Imperial College London" {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.chosenUniversity = UserDefaults.standard.object(forKey: "chosenUniversity") as? String ?? "Imperial College London"
        self.bedHour = UserDefaults.standard.integer(forKey: "bedHour")
        self.bedMinute = UserDefaults.standard.integer(forKey: "bedMinute")
        self.sleepHour = UserDefaults.standard.integer(forKey: "sleepHour")
        self.sleepMinute = UserDefaults.standard.integer(forKey: "sleepMinute")
        self.wakeHour = UserDefaults.standard.integer(forKey: "wakeHour")
        self.wakeMinute = UserDefaults.standard.integer(forKey: "wakeMinute")
        if let data = UserDefaults.standard.data(forKey: "sleep"),
           let tasks = try? JSONDecoder().decode(Task.self, from: data) {
            sleep = tasks
        } else {
            sleep = Task(title: "Sleep", hour: 0, minute: 15, startHour: 0, startMinute: 0, detail: "", referenceLinks: [], before: 5, type: "Sleep")
        }
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
            wakeUpTasks = [Task(title: "Take a Warm Bath", hour: 0, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Listen to Music", hour: 1, minute: 0, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Stretch", hour: 0, minute: 15, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Breathe", hour: 0, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Practice Meditation", hour: 1, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Read a Book", hour: 2, minute: 0, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Write Down a To-Do List", hour: 0, minute: 45, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up")]
        }
        
        if let data6 = UserDefaults.standard.data(forKey: "bedTimeTasks"),
           let tasks6 = try? JSONDecoder().decode([Task].self, from: data6) {
            bedTimeTasks = tasks6
        } else {
            bedTimeTasks = [Task(title: "Take a Warm Bath", hour: 0, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Listen to Music", hour: 1, minute: 0, type: "Bedtime"), Task(title: "Stretch", hour: 0, minute: 15, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Breathe", hour: 0, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Practice Meditation", hour: 1, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Read a Book", hour: 2, minute: 0, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Write Down a To-Do List", hour: 0, minute: 45, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime")]
        }
        
        if let data7 = UserDefaults.standard.data(forKey: "wakeUpRoutine"),
           let tasks7 = try? JSONDecoder().decode([Task].self, from: data7) {
            wakeUpRoutine = tasks7
        } else {
            wakeUpRoutine = [Task(title: "Take a Warm Bath", hour: 0, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Listen to Music", hour: 1, minute: 0, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Stretch", hour: 0, minute: 15, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Breathe", hour: 0, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Practice Meditation", hour: 1, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Read a Book", hour: 2, minute: 0, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up"), Task(title: "Write Down a To-Do List", hour: 0, minute: 45, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Wake Up")]
        }
        
        if let data8 = UserDefaults.standard.data(forKey: "bedTimeRoutine"),
           let tasks8 = try? JSONDecoder().decode([Task].self, from: data8) {
            bedTimeRoutine = tasks8
        } else {
            bedTimeRoutine = [Task(title: "Take a Warm Bath", hour: 0, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Listen to Music", hour: 1, minute: 0, type: "Bedtime"), Task(title: "Stretch", hour: 0, minute: 15, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Breathe", hour: 0, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Practice Meditation", hour: 1, minute: 30, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Read a Book", hour: 2, minute: 0, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime"), Task(title: "Write Down a To-Do List", hour: 0, minute: 45, referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime")]
        }
        
        
    }
    
    private func saveSleep() {
        if let data = try? JSONEncoder().encode(sleep) {
            UserDefaults.standard.set(data, forKey: "sleep")
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
