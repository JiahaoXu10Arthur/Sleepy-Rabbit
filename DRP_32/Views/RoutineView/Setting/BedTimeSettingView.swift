//
//  BedTimeSettingView.swift
//  DRP_32
//
//  Created by paulodybala on 05/06/2023.
//

import SwiftUI

struct BedTimeSettingView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    // Default time
    
    @AppStorage("sleepHour") var sleepHour = 0
    @AppStorage("sleepMinute") var sleepMinute = 0
    @AppStorage("wakeHour") var wakeHour = 0
    @AppStorage("wakeMinute") var wakeMinute = 0
    @AppStorage("bedHour") var bedHour = 0
    @AppStorage("bedMinute") var bedMinute = 0
    
    private let hours = [Int](0...24)
    private let minutes = [Int](0...60)
    
    
    var tasks: [Task] {
        settings.tasks
    }
    
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    
    var sleepingTime: String {
        var hour = wakeHour - sleepHour
        var minute = wakeMinute - sleepMinute
        if minute < 0 {
            minute = 60 + minute
            hour -= 1
        }
        if hour < 0 {
            hour = 24 + hour
        }
        bedHour = hour
        bedMinute = minute
        return "\(formatTime(_:bedHour)): \(formatTime(_:bedMinute))"
    }
    
    /*
     View for the Bed Time Setting
     */
    var body: some View {
        VStack {
            Form {
                Section (header: Text("Sleep Time Setting")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)){
                        Text("Bed Time \(sleepingTime)")
                            .font(.title3)
                        
                        HStack {
                            VStack {
                                Text("Wake up \nTime")
                                    .font(.title3)
                            }
                            WakeUpTimePickerView(wakeHour: $wakeHour, wakeMinute: $wakeMinute)
                                .frame(height: 100.0)
                            
                        }
                        HStack {
                            VStack {
                                Text("Sleeping\nDuration")
                                    .font(.title3)
                            }
                            CustomDatePicker(sleepHour: $sleepHour, sleepMinute: $sleepMinute)
                                .frame(height: 100.0)
                        }
                    }
            }
            .navigationTitle(Text("Bed Time Setting"))
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NextButton(bedHour: $bedHour, bedMinute: $bedMinute, sleepHour: $sleepHour, sleepMinute: $sleepMinute)
                }
            }
            
            
        }
    }
    
    
}

struct BedTimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BedTimeSettingView()
            .environmentObject(UserSettings.shared)
    }
}
