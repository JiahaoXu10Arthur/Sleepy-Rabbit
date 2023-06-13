//
//  task.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import Foundation

struct Task: Identifiable, Equatable, Codable{
    var id = UUID()
    let title: String
    let hour: Int
    let minute: Int
    var startHour = -1
    var startMinute = -1
    var detail = ""
}
