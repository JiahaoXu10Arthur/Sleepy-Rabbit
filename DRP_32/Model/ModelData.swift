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
    
    // Property to store the fetched data
    @Published var tips: [Tip]?
    
    @Published var showingTip: Tip?
    
    @Published var queryTip: Tip?
    
    @Published var tipOfTheDay: Tip?
    
    @Published var isLoading: Bool = true

    private init() {
        fetchTipofTheDay() { _ in}
        fetchData()
//        getAnAiTip() { _ in
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }
        getAndCacheAiTip() { _ in
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
        }
        self.isLoading = false
    } // Prevents others from creating their own instances

    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    
    func fetchData() {
        let urlString = "https://drp32-backend.herokuapp.com/tips/all"
        fetchDatas(urlString: urlString) { (fetchedData: [Tip]?, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.tips = []
                    print("Error fetching data: \(error)")
                } else if let fetchedData = fetchedData {
                    self.tips = fetchedData.reversed()
                }
            }
        }
    }
    
    func getAnAiTip(retries: Int = 3, completion: @escaping (Tip?) -> Void) {
        guard retries > 0 else {
            print("Max retries reached. Fetch failed.")
            self.showingTip = Tip(title: "Failed", tag: ":(", detail: "Get Tip Failed")
            completion(nil)
            return
        }
        
        let url = "https://drp32-backend.herokuapp.com/getRandomTip"
        fetchOneData(urlString: url) { (tip: Tip?, error) in
            DispatchQueue.main.async {
                if let tip = tip {
                    self.showingTip = tip
                    completion(tip)
                } else {
                    print("Fetch failed. Retrying...")
                    self.getAnAiTip(retries: retries - 1, completion: completion)
                }
            }
        }
    }
    
    func getAnAiTip1(retries: Int = 3, completion: @escaping (Tip?) -> Void) {
        guard retries > 0 else {
            print("Max retries reached. Fetch failed.")
            completion(nil)
            return
        }
        
        let url = "https://drp32-backend.herokuapp.com/getRandomTip"
        fetchOneData(urlString: url) { (tip: Tip?, error) in
            DispatchQueue.main.async {
                if let tip = tip {
                    completion(tip)
                } else {
                    print("Fetch failed. Retrying...")
                    self.getAnAiTip(retries: retries - 1, completion: completion)
                }
            }
        }
    }
    
    func getAndCacheAiTip(completion: @escaping (Tip?) -> Void) {
        var cachedTips: [Tip] = load("CachedTips.json")
        if cachedTips.count > 0 {
            self.showingTip = cachedTips[0]
            getAnAiTip1() { tip in
                if let tip = tip {
                    cachedTips.remove(at: 0)
                    cachedTips.append(tip)
                } else {
                    cachedTips.reverse()
                }
                self.write(data: cachedTips, "CachedTips.json")
                completion(tip)
            }
        } else {
            print("CachedTips JSON file empty")
            completion(nil)
        }
    }
    
    func getQueryTip(retries: Int = 3, query: Query, completion: @escaping (Tip?) -> Void) {
        guard retries > 0 else {
            print("Max retries reached. Fetch failed.")
            self.showingTip = Tip(title: "Failed", tag: ":(", detail: "Get Tip Failed")
            completion(nil)
            return
        }
        
        let url = "https://drp32-backend.herokuapp.com/getQueryTip"
        postData(urlString: url, data: query) { (tip: Tip?, error) in
            DispatchQueue.main.async {
                if let tip = tip {
                    self.showingTip = tip
                    completion(tip)
                } else {
                    print("Fetch failed. Retrying...")
                    self.getQueryTip(retries: retries - 1, query: query, completion: completion)
                }
            }
        }
    }
    
    func fetchTipofTheDay(completion: @escaping (Tip?) -> Void) {
        let url = "https://drp32-backend.herokuapp.com/tips/daily"
        fetchOneData(urlString: url) { (tip: Tip?, error) in
            DispatchQueue.main.async {
                if let tip = tip {
                    self.tipOfTheDay = tip
                } else {
                    self.tipOfTheDay = Tip(title: "Failed", tag: ":(", detail: "Get Tip Failed")
                }
                completion(tip)
            }
        }
    }
    
    func updateLike(like: Bool, completion: @escaping (Bool) -> Void) {
        let url1 = like ? "https://drp32-backend.herokuapp.com/tips/like" : "https://drp32-backend.herokuapp.com/tips/dislike"
        let url = URL(string: url1)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(false)
                } else if data != nil {
                    completion(true)
                }
            }
        }
        task.resume()
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

    func write<T: Encodable>(data: T, _ filename: String) -> Void {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            let editedData = try JSONEncoder().encode(data)
            try editedData.write(to: file)
        } catch {
            print("Error: \(error)")
        }
    }

}
