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
    
    @Published var loadingTipofTheDay = true
    
    @Published var isDisabled: Bool = true
    
    private var lock = NSLock()

    private init() {
        setupDataFile()
        fetchTipofTheDay() { _ in
            self.loadingTipofTheDay = false
        }
        fetchData()
//        getAnAiTip() { _ in
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }
        getAndCacheAiTipSync() { _ in
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
        }
        self.isLoading = false
        self.isDisabled = false
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
    
    func getAnAiTip1(retries: Int = 5, completion: @escaping (Tip?) -> Void) {
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
    
//    func getAndCacheAiTipSync(completion: @escaping (Tip?) -> Void) {
//        lock.lock()
//        var cachedTips: [Tip] = load("CachedTips.json")
//        if cachedTips.count > 0 {
//            self.showingTip = cachedTips[0]
//            cachedTips.remove(at: 0)
//            if cachedTips.count == 0 {
//                self.isDisabled = true
//            }
//            self.write(data: cachedTips, "CachedTips.json")
//            lock.unlock()
//            getAnAiTip1() { tip in
//                self.lock.lock()
//                cachedTips = self.load("CachedTips.json")
//                if let tip = tip {
//                    //                    cachedTips.remove(at: 0)
//                    cachedTips.append(tip)
//                } else {
//                    cachedTips.append(Tip(title: "White Noise for Better Sleep", tag: "#sleep#chatGPT", detail: "Playing white noise in the background during sleep can help drown out external noise and create a calming environment. This can lead to better sleep quality and more restful nights."))
//                }
//                self.write(data: cachedTips, "CachedTips.json")
//                self.isDisabled = false
//                completion(tip)
//                self.lock.unlock()
//            }
//        } else {
//            print("CachedTips JSON file empty")
//            self.lock.unlock()
//            completion(nil)
//        }
//    }
    
    func getAndCacheAiTipSync(completion: @escaping (Tip?) -> Void) {
        lock.lock()
        var cachedTips: [Tip] = urlLoad(getDocumentsDirectory())
        
        // If there are no tips left, or if we're already fetching a tip, return immediately
        if cachedTips.isEmpty || self.isDisabled {
            lock.unlock()
            completion(nil)
            return
        }
        
        // Remove the first tip and show it
        self.showingTip = cachedTips.removeFirst()
        self.urlWrite(data: cachedTips, getDocumentsDirectory())
        
        // Set isDisabled to true to prevent fetching more tips until this fetch is finished
        if cachedTips.count == 0 {
            self.isDisabled = true
        }
        
        lock.unlock()
        
        // Fetch a new tip to replenish the cache
        getAnAiTip1() { tip in
            self.lock.lock()
            
            // Load the latest cache
            cachedTips = self.urlLoad(self.getDocumentsDirectory())
            
            // Append a new tip to the cache
            if let tip = tip {
                cachedTips.append(tip)
            } else {
                cachedTips.append(Tip(title: "White Noise for Better Sleep", tag: "#sleep#chatGPT", detail: "Playing white noise in the background during sleep can help drown out external noise and create a calming environment. This can lead to better sleep quality and more restful nights."))
            }
            
            self.urlWrite(data: cachedTips, self.getDocumentsDirectory())
            
            // Fetching is done, allow more tips to be fetched
            self.isDisabled = false
            self.lock.unlock()
            
            // Return the tip
            completion(self.showingTip)
        }
    }

    
    func getQueryTip(retries: Int = 5, query: Query, completion: @escaping (Tip?) -> Void) {
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
    
    func urlLoad<T: Decodable>(_ url: URL) -> T {
        let data: Data
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Couldn't load \(url) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(url) as \(T.self):\n\(error)")
        }
    }
    
    func urlWrite<T: Encodable>(data: T, _ url: URL) {
        do {
            let editedData = try JSONEncoder().encode(data)
            try editedData.write(to: url)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("CachedTips.json")
    }
    
    func setupDataFile() {
        let fileURL = getDocumentsDirectory()
        
        // Check if file already exists
        if FileManager.default.fileExists(atPath: fileURL.path) {
            print("File already exists at \(fileURL.path)")
        } else {
            // Copy the default data from the bundled file to the Application Support directory
            if let bundledData = Bundle.main.url(forResource: "CachedTips", withExtension: "json") {
                do {
                    let applicationSupportDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
                    do {
                        try FileManager.default.createDirectory(at: applicationSupportDirectory, withIntermediateDirectories: true, attributes: nil)
                    } catch {
                        print("Error creating Application Support directory: \(error)")
                    }

                    try FileManager.default.copyItem(at: bundledData, to: fileURL)
                } catch {
                    print("Error occurred while copying file to document directory: \(error)")
                }
            } else {
                print("Default bundled data not found")
            }
        }
    }

}
