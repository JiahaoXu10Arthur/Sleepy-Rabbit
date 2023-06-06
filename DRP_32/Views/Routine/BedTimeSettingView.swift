//
//  SwiftUIView.swift
//  DRP_32
//
//  Created by paulodybala on 05/06/2023.
//

import SwiftUI

extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}

struct BedTimeSettingView: View {
    
    @State private var currentDate = Date()
    @AppStorage("bedTime") var bedTime = Date()
    @AppStorage("wakeUpTime") var wakeUpTime = Date()
    
    var todayRange: ClosedRange<Date> {
           let calendar = Calendar.current
           var endComponents = DateComponents()
           endComponents.day = 1

           let endDate = calendar.date(byAdding: endComponents, to: Date.now)!
           return Date.now ... endDate
       }
    
    var tomorrowRange: ClosedRange<Date> {
            let calendar = Calendar.current
            var startComponents = DateComponents()
            startComponents.day = 2
            var endComponents = DateComponents()
            endComponents.day = 1

            let correctStartDate = bedTime
            let startDate = calendar.date(byAdding: .day, value: 0, to: correctStartDate)!
            let endDate = calendar.date(byAdding: .day, value: 1, to: correctStartDate)!
            return startDate ... endDate
        }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Bed Time", selection: $bedTime,in: todayRange, displayedComponents: .hourAndMinute)
                        .padding()
                    DatePicker("Wake Up Time", selection: $wakeUpTime,
                               in: tomorrowRange ,displayedComponents: .hourAndMinute)
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "moon.zzz.fill")
                        Text("\(sleepingTime)").font(.title2)
                    }
                   
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Sleeping Time Settings")
        }

        var sleepingTime: String {
               let components = Calendar.current.dateComponents([.hour, .minute], from: bedTime, to: wakeUpTime)
               let hours = components.hour ?? 0
               let minutes = components.minute ?? 0
               return "\(hours) hours \(minutes) minutes"
           }
        
    }
}

struct BedTimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BedTimeSettingView()
    }
}
