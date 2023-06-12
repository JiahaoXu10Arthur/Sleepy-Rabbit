//
//  NewTaskView.swift
//  DRP_32
//
//  Created by paulodybala on 09/06/2023.
//

import SwiftUI

struct NewTaskView: View {
    @EnvironmentObject var settings: UserSettings
    
    @State var title: String = ""
    @State var hour: Int = 0
    @State var minute: Int = 0
    @State var startHour: Int = 0
    @State var startMinute: Int = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
            }
            Section {
                HStack {
                    VStack {
                        Text("Duration")
                            .font(.title3)
                    }
                    CustomDatePicker(sleepHour: $hour, sleepMinute: $minute)
                        .frame(height: 100.0)
                }
            }
            
        }
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
