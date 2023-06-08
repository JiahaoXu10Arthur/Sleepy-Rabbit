//
//  Calendar.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        TimeLineView()
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(ModelData.shared)
            .environmentObject(UserSettings.shared)
    
    }
}
