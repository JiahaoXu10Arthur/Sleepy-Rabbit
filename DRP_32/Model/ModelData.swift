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
    
    @Published var tasks: [Task] = [Task(title: "Task 1", hour: 1, minute: 30), Task(title: "Task 2", hour: 0, minute: 21), Task(title: "Task 3", hour: 3, minute: 51)]
    @Published var chosenTasks: [Task] = []

    // Property to store the fetched data
    @Published var tips: [Tip]?
    
    @Published var showingTip: Tip?
    
    @Published var queryTip: Tip?
    
    @Published var isLoading: Bool = true

    private init() {
        fetchData()
        getAnAiTip() { _ in
            self.isLoading = false
        }
    } // Prevents others from creating their own instances

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
