//
//  task.swift
//  DRP_32
//
//  Created by paulodybala on 06/06/2023.
//

import Foundation

struct Task: Identifiable, Equatable, Codable{
    var id = UUID()
    var title: String
    var hour: Int
    var minute: Int
    var startHour = -1
    var startMinute = -1
    var detail = ""

}
