//
//  File.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/6/1.
//

import Foundation

struct Todo: Hashable, Codable, Identifiable {
    var id: UUID
    var title: String
}
