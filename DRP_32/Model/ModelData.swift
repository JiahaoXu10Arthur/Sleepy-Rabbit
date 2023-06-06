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

}
