//
//  main.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/1.
//

//import Foundation
//
//struct Todo: Hashable, Codable, Identifiable {
//    var id: UUID
//    var title: String
//}
//
//let semaphore = DispatchSemaphore(value: 0)
//let url = URL(string: "https://drp32-backend.herokuapp.com/todos")!
//let decoder = JSONDecoder()
//let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//    print("test")
//    if let error = error {
//        print("Error: \(error)")
//    } else if let data = data {
//        do {
//            let todo = try decoder.decode([Todo].self, from: data)
//            print("Recieved \(todo[0].title)")
//        } catch {
//            print("parse failed")
//        }
//        //print("Received data:\n\(str ?? "")")
//    }
//    semaphore.signal()
//}
//
//task.resume()
//semaphore.wait()
