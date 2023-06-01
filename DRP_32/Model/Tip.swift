//
//  Tips.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/1.
//

import Foundation

struct Tip: Codable {
    var id: UUID?
    var tip: String
    var author: String?
    var date: Date?
    var likes: Int?
    var dislikes: Int?
}
