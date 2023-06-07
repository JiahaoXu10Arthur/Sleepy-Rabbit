//
//  HttpOperations.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/1.
//

import Foundation

func fetchDatas<T: Codable>(urlString: String, completion: @escaping ([T]?, Error?) -> Void) {
    let url = URL(string: urlString)!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(nil, error)
        } else if let data = data {
            do {
                let decoder = JSONDecoder()
                let todos = try decoder.decode([T].self, from: data)
                completion(todos, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    task.resume()
}

func fetchOneData<T: Codable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
    let url = URL(string: urlString)!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(nil, error)
        } else if let data = data {
            do {
                let decoder = JSONDecoder()
                let todo = try decoder.decode(T.self, from: data)
                completion(todo, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    task.resume()
}

func postData<T: Codable, S: Codable>(urlString: String, data: S, completion: @escaping (T?, Error?) -> Void) {
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let jsonData = try? JSONEncoder().encode(data)  // `user` is the data you want to send
    request.httpBody = jsonData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(nil, error)
        } else if let data = data {
            do {
                let decoder = JSONDecoder()
                let todo = try decoder.decode(T.self, from: data)
                completion(todo, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    task.resume()
}

func getAiTip(completion: @escaping (Tip?) -> Void) {
    let url = "https://drp32-backend.herokuapp.com/getRandomTip"
    fetchOneData(urlString: url) { (tip: Tip?, error) in
        if let tip = tip {
            completion(tip)
        } else {
            completion(nil)
        }
    }
}
