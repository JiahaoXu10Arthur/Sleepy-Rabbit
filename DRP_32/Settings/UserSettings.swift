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
    
    @Published var liked: Bool {
        didSet {
            saveLiked()
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
        
        if let data99 = UserDefaults.standard.data(forKey: "liked"),
           let found = try? JSONDecoder().decode(Bool.self, from: data99) {
            liked = found
        } else {
            liked = false
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
            wakeUpTasks = [
                Task(title: "Drink a full glass of water", hour: 0, minute: 15, detail: "Hydration is key to your health and well being. Drinking water is a crucial component of a great morning routine because when you feel good, you’re more focused and, as a result, more productive.\nCreate a routine of staying hydrated in the morning by drinking a full glass of water when you first wake up. It’s a good idea to do this before your morning cup of coffee or tea to avoid forgetting. This also combats any dehydration that occurs from caffeinated drinks.", type: "Wake Up"),
                Task(title: "Meditate by taking deep breaths", hour: 0, minute: 30, detail: "Meditation can support relaxation and can go hand in hand with positive affirmations. For those who would prefer a relaxing routine, take time to sit with your thoughts and breathe deeply.\nCreate an efficient routine by pairing your affirmations with a deep breathing exercise such as roll breathing. Say your affirmations in your head while you’re in a state of calmness or out loud while breathing for stress management.", referenceLinks: ["https://www.youtube.com/watch?v=8Ix9gPr6YA8"], type: "Wake Up"),
                Task(title: "Prepare a healthy breakfast", hour: 0, minute: 45,detail: "To fuel your inspiration and start your day off right, prepare a healthy breakfast with ingredients that make you feel good. \nPrepare a healthy breakfast\nEating healthy can be easier than you think. A simple bowl of oatmeal or a quick smoothie can support your health without requiring a lot of prep time. \nGiven that tasks like preparing food during the middle of the day can disrupt productivity, it’s a good idea to meal prep if you have the time. Take a few extra minutes in the morning to gather ingredients for lunch so they’re ready to go when midday rolls around.", referenceLinks: ["https://www.loveandlemons.com/healthy-breakfast-ideas/"], type: "Wake Up")
               ]
        }
        
        if let data6 = UserDefaults.standard.data(forKey: "bedTimeTasks"),
           let tasks6 = try? JSONDecoder().decode([Task].self, from: data6) {
            bedTimeTasks = tasks6
        } else {
            bedTimeTasks = [
                Task(title: "Dim the Lights", hour: 0, minute: 15, detail: "Turning off or lowering bright lights can help with the process. As we know with screen time, exposure to bright lights before bedtime affects the circadian rhythm. Creating a cozy, cool and dark sleeping space will help set your circadian rhythm to sleep mode.", type: "Bedtime"),
                Task(title: "Take a Warm Bath", hour: 0, minute: 30, detail: "As part of the sleep-wake cycle, your body experiences various metabolic changes throughout the day. One of these is melatonin production, which begins in the evening to prepare you for sleep, as well as a drop in your core body temperature Scientists have found that mimicking a nighttime drop in body temperature via a warm bath can trigger a similarly sleepy reaction. Consider taking a warm bath about an hour before you go to sleep.\nYour body will heat up from the water, and cool down quickly as the water evaporates, creating a sensation that makes you feel tired and relaxed.", referenceLinks: ["https://journals.sagepub.com/doi/10.1177/074873049701200604"], type: "Bedtime"),
                Task(title: "Drinking Something Warm", hour: 0, minute: 15, detail: "Drinking a warm cup of tea or your favorite beverage can warm you up and get you in the mood for bedtime. Chamomile tea has been used for centuries to treat sleep disorders and insomnia. For kids, drinking warm milk can help encourage sleep. As adults, chamomile is the bedtime go-to.\nTurmeric is a superfood that helps you sleep and can help combat depression and inflammation, plus provide pain relief. The herb can be purchased at the grocery store or at a local farmer’s market. Turmeric can be a little bitter, so try creating a bedtime concoction like turmeric golden milk to sweeten up the flavor.", type: "Bedtime"),
                Task(title: "Write Down a To-Do List", hour: 0, minute: 45, detail: "Creating a to-do list prevents the mind from worrying about tomorrow’s tasks. Bedtime writing is a mental dump of information that organizes future responsibilities and allows you to release anxiety. When you wake up in the morning, you’ll have an itinerary ready to start the day.", referenceLinks: ["https://psycnet.apa.org/record/2017-47677-001"], type: "Bedtime"),
                Task(title: "Listen to Music", hour: 1, minute: 0, detail: "Making a bedtime playlist can help you start letting go of mental attachments. Psychology studies have shown that listening to music can help encourage sleep and improve sleep quality. In one sleep study, 62 percent of participants reported using music in their nightly routines to help lessen stress.\nListening to music, particularly classical music, has been found to help with sleep, but don’t feel obligated to listen to a specific genre. Try some R&B, bossa nova or jazz. As long as it helps your sleep routine, it should help you sleep more soundly.", referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ", "https://www.youtube.com/watch?v=X3rJY63t5C8"], type: "Bedtime")
                ]
        }
        
        if let data7 = UserDefaults.standard.data(forKey: "wakeUpRoutine"),
           let tasks7 = try? JSONDecoder().decode([Task].self, from: data7) {
            wakeUpRoutine = tasks7
        } else {
            wakeUpRoutine = [
                Task(title: "Drink a full glass of water", hour: 0, minute: 15, detail: "Hydration is key to your health and well being. Drinking water is a crucial component of a great morning routine because when you feel good, you’re more focused and, as a result, more productive.\nCreate a routine of staying hydrated in the morning by drinking a full glass of water when you first wake up. It’s a good idea to do this before your morning cup of coffee or tea to avoid forgetting. This also combats any dehydration that occurs from caffeinated drinks.", type: "Wake Up"),
                Task(title: "Meditate by taking deep breaths", hour: 0, minute: 30, detail: "Meditation can support relaxation and can go hand in hand with positive affirmations. For those who would prefer a relaxing routine, take time to sit with your thoughts and breathe deeply.\nCreate an efficient routine by pairing your affirmations with a deep breathing exercise such as roll breathing. Say your affirmations in your head while you’re in a state of calmness or out loud while breathing for stress management.", referenceLinks: ["https://www.youtube.com/watch?v=8Ix9gPr6YA8"], type: "Wake Up"),
                Task(title: "Prepare a healthy breakfast", hour: 0, minute: 45,detail: "To fuel your inspiration and start your day off right, prepare a healthy breakfast with ingredients that make you feel good. \nPrepare a healthy breakfast\nEating healthy can be easier than you think. A simple bowl of oatmeal or a quick smoothie can support your health without requiring a lot of prep time. \nGiven that tasks like preparing food during the middle of the day can disrupt productivity, it’s a good idea to meal prep if you have the time. Take a few extra minutes in the morning to gather ingredients for lunch so they’re ready to go when midday rolls around.", referenceLinks: ["https://www.loveandlemons.com/healthy-breakfast-ideas/"], type: "Wake Up")
               ]
        }
        
        if let data8 = UserDefaults.standard.data(forKey: "bedTimeRoutine"),
           let tasks8 = try? JSONDecoder().decode([Task].self, from: data8) {
            bedTimeRoutine = tasks8
        } else {
            bedTimeRoutine = [
                Task(title: "Dim the Lights", hour: 0, minute: 15, detail: "Turning off or lowering bright lights can help with the process. As we know with screen time, exposure to bright lights before bedtime affects the circadian rhythm. Creating a cozy, cool and dark sleeping space will help set your circadian rhythm to sleep mode.", type: "Bedtime"),
                Task(title: "Take a Warm Bath", hour: 0, minute: 30, detail: "As part of the sleep-wake cycle, your body experiences various metabolic changes throughout the day. One of these is melatonin production, which begins in the evening to prepare you for sleep, as well as a drop in your core body temperature Scientists have found that mimicking a nighttime drop in body temperature via a warm bath can trigger a similarly sleepy reaction. Consider taking a warm bath about an hour before you go to sleep.\nYour body will heat up from the water, and cool down quickly as the water evaporates, creating a sensation that makes you feel tired and relaxed.", referenceLinks: ["https://journals.sagepub.com/doi/10.1177/074873049701200604"], type: "Bedtime"),
                Task(title: "Drinking Something Warm", hour: 0, minute: 15, detail: "Drinking a warm cup of tea or your favorite beverage can warm you up and get you in the mood for bedtime. Chamomile tea has been used for centuries to treat sleep disorders and insomnia. For kids, drinking warm milk can help encourage sleep. As adults, chamomile is the bedtime go-to.\nTurmeric is a superfood that helps you sleep and can help combat depression and inflammation, plus provide pain relief. The herb can be purchased at the grocery store or at a local farmer’s market. Turmeric can be a little bitter, so try creating a bedtime concoction like turmeric golden milk to sweeten up the flavor.", type: "Bedtime"),
                Task(title: "Write Down a To-Do List", hour: 0, minute: 45, detail: "Creating a to-do list prevents the mind from worrying about tomorrow’s tasks. Bedtime writing is a mental dump of information that organizes future responsibilities and allows you to release anxiety. When you wake up in the morning, you’ll have an itinerary ready to start the day.", referenceLinks: ["https://psycnet.apa.org/record/2017-47677-001"], type: "Bedtime"),
                Task(title: "Listen to Music", hour: 1, minute: 0, detail: "Making a bedtime playlist can help you start letting go of mental attachments. Psychology studies have shown that listening to music can help encourage sleep and improve sleep quality. In one sleep study, 62 percent of participants reported using music in their nightly routines to help lessen stress.\nListening to music, particularly classical music, has been found to help with sleep, but don’t feel obligated to listen to a specific genre. Try some R&B, bossa nova or jazz. As long as it helps your sleep routine, it should help you sleep more soundly.", referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ", "https://www.youtube.com/watch?v=X3rJY63t5C8"], type: "Bedtime")
                ]
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
    
    private func saveLiked() {
        if let data = try? JSONEncoder().encode(liked) {
            UserDefaults.standard.set(data, forKey: "liked")
        }
    }
    
    private func saveNotification() {
        if let data = try? JSONEncoder().encode(allowNotification) {
            UserDefaults.standard.set(data, forKey: "allowNotification")
        }
    }
    
}
