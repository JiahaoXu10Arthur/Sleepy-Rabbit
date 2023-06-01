//
//  ModelData.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/1.
//

import Foundation

class ModelData {
    // Make DatabaseManager a singleton
    static let shared = ModelData()

    // Property to store the fetched data
    var data: [Tip]?

    private init() {
        fetchData()
    } // Prevents others from creating their own instances

    func fetchData() {
        let urlString = "https://drp32-backend.herokuapp.com/tips/all"
        fetchDatas(urlString: urlString) { (fetchedData: [Tip]?, error) in
            if let error = error {
                self.data = []
                print("Error fetching data: \(error)")
            } else if let fetchedData = fetchedData {
                self.data = fetchedData
            }
        }
    }
}
