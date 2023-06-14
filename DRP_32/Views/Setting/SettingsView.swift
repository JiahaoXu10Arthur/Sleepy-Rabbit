//
//  SettingsView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isSetting: Bool
    @State var showNotificationSettingsUI = false
    @State var showBedtime = false
    @State var showWakeUp = false
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Sleep Time Setting")) {
                    NavigationLink(destination: BedTimeSettingView()) {
                        HStack {
                            Image(systemName: "bed.double.circle.fill")
                                .foregroundColor(Color.blue)
                                .font(.title)
                                .accentColor(.pink)
                            
                            Text("Sleep Time Setting")
                                .font(.title2)
                        }
                    }
                }
                Section(header: Text("Rearrange Routine")) {
                    
                    HStack {
                        Image(systemName: "sunset.circle.fill")
                        
                            .foregroundColor(Color(red: 25/255, green: 25/255, blue: 112/255, opacity: 1.0))
                            .font(.title)
                            .accentColor(.pink)
                        
                        Text("Bedtime Tasks")
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            showBedtime.toggle()
                        }) {
                            Image(systemName: "info.circle")
                                .font(.title2)
                        }
                        
                    }
                    
                    
                    HStack {
                        Image(systemName: "sunrise.circle.fill")
                            .foregroundColor(Color.orange)
                            .font(.title)
                            .accentColor(.pink)
                        
                        Text("Wake Up Tasks")
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            showWakeUp.toggle()
                        }) {
                            Image(systemName: "info.circle")
                                .font(.title2)
                        }
                    }
                    
                }
                Section(header: Text("Notifications settings")) {
                    Button(action: {
                        NotificationManager.shared.requestAuthorization{ granted in
                            
                            // 2
                            if granted {
                                
                                showNotificationSettingsUI = true
                            }
                        }
                        
                    }) {
                        HStack {
                            Image(systemName: "bell.badge.circle.fill")
                                .foregroundColor(Color.blue)
                                .font(.title)
                                .accentColor(.pink)
                            
                            Text("Enable Notification")
                                .font(.title2)
                        }
                        
                    }
                }
                Section(header: Text("For Testing")) {
                    Button(action: {
                        settings.showOnboarding = true
                    }) {
                        Text("Show Onboarding")
                            .font(.title2)
                    } //: BUTTON
                    
                }
            
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    DoneButton(isSetting: $isSetting)
                    
                }
                
            }
            .sheet(isPresented: $showBedtime) {
                BedTimeRoutineView()
            }
            .sheet(isPresented: $showWakeUp) {
                WakeUpRoutineView()
            }
        
            
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isSetting: .constant(true))
            .environmentObject(UserSettings.shared)
    }
}
