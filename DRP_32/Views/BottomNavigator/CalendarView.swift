//
//  Calendar.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            Image(systemName: "calendar")
                .foregroundColor(.blue)
            Text("This is a Calendar")
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
