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
    
    @Published var aiTip: Tip?

    private init() {
        fetchData()
        getAnAiTip() { _ in}
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
                self.aiTip = tip
            } else {
                self.aiTip = Tip(title: "Failed", tag: ":(", detail: "Get Tip Failed")
            }
            DispatchQueue.main.async {
                    completion(tip)
                }
        }
        
    }

}
