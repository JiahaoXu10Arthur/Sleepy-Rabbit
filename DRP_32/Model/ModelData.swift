//
//  ModelData.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/1.
//

import Foundation
import Combine

class ModelData: ObservableObject {
    // Make DatabaseManager a singleton
    static let shared = ModelData()
    
    @Published var tasks: [Task] = [Task(title: "Take a Warm Bath", hour: 0, minute: 30), Task(title: "Listen to Music", hour: 1, minute: 0), Task(title: "Stretch", hour: 0, minute: 15), Task(title: "Breathe", hour: 0, minute: 30), Task(title: "Practice Meditation", hour: 1, minute: 30), Task(title: "Read a Book", hour: 2, minute: 0), Task(title: "Write Down a To-Do List", hour: 0, minute: 20)]
    @Published var chosenTasks: [Task] {
        didSet {
                   saveTasks()
               }
    }

    
    // Property to store the fetched data
    @Published var tips: [Tip]?
    
    @Published var showingTip: Tip?
    
    @Published var queryTip: Tip?
    
    @Published var isLoading: Bool = true

    private init() {
        if let data = UserDefaults.standard.data(forKey: "chosenTasks"),
           let tasks = try? JSONDecoder().decode([Task].self, from: data) {
            chosenTasks = tasks
        } else {
            chosenTasks = []
        }
        fetchData()
        getAnAiTip() { _ in
            self.isLoading = false
        }
    } // Prevents others from creating their own instances

    private func saveTasks() {
            if let data = try? JSONEncoder().encode(chosenTasks) {
                UserDefaults.standard.set(data, forKey: "chosenTasks")
            }
        }
    
    func fetchData() {
        let urlString = "https://drp32-backend.herokuapp.com/tips/all"
        fetchDatas(urlString: urlString) { (fetchedData: [Tip]?, error) in
            if let error = error {
                self.tips = []
                print("Error fetching data: \(error)")
            } else if let fetchedData = fetchedData {
                self.tips = fetchedData.reversed()
            }
        }
    }
    
    func getAnAiTip(completion: @escaping (Tip?) -> Void) {
        let url = "https://drp32-backend.herokuapp.com/getRandomTip"
        fetchOneData(urlString: url) { (tip: Tip?, error) in
            if let tip = tip {
                self.showingTip = tip
            } else {
                self.showingTip = Tip(title: "Failed", tag: ":(", detail: "Get Tip Failed")
            }
            DispatchQueue.main.async {
                    completion(tip)
                }
        }
    }
    
    func getQueryTip(query: Query, completion: @escaping (Tip?) -> Void) {
        let url = "https://drp32-backend.herokuapp.com/getQueryTip"
        postData(urlString: url, data: query) { (tip: Tip?, error) in
            if let tip = tip {
                self.showingTip = tip
            } else {
                self.showingTip = Tip(title: "Failed", tag: ":(", detail: "Get Tip Failed")
            }
            DispatchQueue.main.async {
                    completion(tip)
                }
        }
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }



}
