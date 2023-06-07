//
//  BedTimeSettingView.swift
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
    
    @EnvironmentObject var modelData: ModelData
    
    @Binding var showOnboarding: Bool
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
        modelData.tasks
    }
    
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
    
   var sleepingTime: String {
       var hours = wakeHour - sleepHour
       var minutes = wakeMinute - sleepMinute
       if minutes < 0 {
           minutes = 60 + minutes
           hours -= 1
       }
       if hours < 0 {
           hours = 24 + hours
       }
       bedHour = hours
       bedMinute = minutes
       return "\(formatTime(_:hours)): \(formatTime(_:minutes))"
   }
    
    /*
     View for the Bed Time Setting
     */
    var body: some View {
        
        VStack {
            VStack {
                Text("Routine Settings")
                    .font(.title)
                    .fontWeight(.bold)
                
                .padding()
            }
            
            Form {
                Section (header: Text("Sleep Time Setting")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)){
                        Text("Bed Time \(sleepingTime)")
                            .font(.title3)
                             
                        HStack {
                            VStack {
                                Text("Wake up \n Time")
                                    .font(.title3)
                            }
                            WakeUpTimePickerView(wakeHour: $wakeHour, wakeMinute: $wakeMinute)
                                .frame(height: 100.0)
                                
                        }
                        HStack {
                            VStack {
                                Text("Sleeping \n Time")
                                    .font(.title3)
                            }
                            CustomDatePicker(sleepHour: $sleepHour, sleepMinute: $sleepMinute)
                                .frame(height: 100.0)
                        }
                    }
                Section (header: Text("Select Your Routine")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)){
                        List {
                            ForEach(tasks) { task in
                                TaskCellView(task: task)
                            }
                        }
                    }
                
                Section {
                    StartButtonView(showOnboarding: $showOnboarding, bedHour: $bedHour, bedMinute: $bedMinute, sleepHour: $sleepHour, sleepMinute: $sleepMinute)
                }
            }
        }
    }
}

struct BedTimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BedTimeSettingView(showOnboarding:.constant(true))
            .environmentObject(ModelData.shared)
    }
}
