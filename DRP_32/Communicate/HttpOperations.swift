//
//  HttpOperations.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/1.
//

import Foundation

func fetchTodos(completion: @escaping ([Todo]?, Error?) -> Void) {
    let url = URL(string: "https://drp32-backend.herokuapp.com/todos")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(nil, error)
        } else if let data = data {
            do {
                let decoder = JSONDecoder()
                let todos = try decoder.decode([Todo].self, from: data)
                completion(todos, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    task.resume()
}
