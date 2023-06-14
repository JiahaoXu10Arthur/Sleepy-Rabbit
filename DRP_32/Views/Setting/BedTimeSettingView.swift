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
    @AppStorage("sleepMinute") var sleepMinute = 15
    @AppStorage("wakeHour") var wakeHour = 0
    @AppStorage("wakeMinute") var wakeMinute = 0
    @AppStorage("bedHour") var bedHour = 0
    @AppStorage("bedMinute") var bedMinute = 0
    
    private let hours = [Int](0...24)
    private let minutes = [Int](0...60)
    
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
        return "\(formatTime(_:bedHour)) : \(formatTime(_:bedMinute))"
    }
    
    /*
     View for the Bed Time Setting
     */
    var body: some View {
        NavigationView{
            
            Form {
                Section(footer: Text("Automatic Calculated")){
                    HStack {
                        ColoredIconView(imageName: "bed.double", foregroundColor: .white, backgroundColor: .blue)
                            .font(.title)
                        
                        
                        VStack {
                            Text("\(sleepingTime)")
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.center)
                            Text("Bed Time")
                                .font(.callout)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.leading)
                        
                    }
                    
                }
                Section{
                    HStack {
                        ColoredIconView(imageName: "sun.and.horizon", foregroundColor: .white, backgroundColor: .orange)
                            .font(.title)
                        Text("Wake Up Time")
                            .font(.title)
                            .padding(.leading)
                    }
                    WakeUpTimePickerView(wakeHour: $wakeHour, wakeMinute: $wakeMinute)
                        .frame(height: 120.0)
                }
                Section(footer: Text("Suggested sleep duration: 7-9 hours per night")){
                    
                    HStack {
                        ColoredIconView(imageName: "moon.zzz", foregroundColor: .white, backgroundColor: .purple)
                            .font(.largeTitle)
                        Text("Sleeping Duration")
                            .font(.title)
                            .padding(.leading)
                    }
                   
                    VStack {
                        CustomDatePicker(sleepHour: $sleepHour, sleepMinute: $sleepMinute)
                            .frame(height: 120.0)
                        if sleepHour * 60 + sleepMinute < 15 {
                            Text("Sleep duration should be at least 15 minutes")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.top, 10)
                        }
                    }
                }
                
                
            }
            .navigationTitle(Text("Sleep Time Setting")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.black))
            
            .navigationBarTitleDisplayMode(.large)
            .navigationViewStyle(StackNavigationViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onDisappear {
                DispatchQueue.main.async {
                    settings.bedHour = bedHour
                    settings.bedMinute = bedMinute
                    settings.sleepHour = sleepHour
                    settings.sleepMinute = sleepMinute
                    settings.wakeHour = wakeHour
                    settings.wakeMinute = wakeMinute
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
