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
    @State var startHour: Int = -1
    @State var startMinute: Int = -1
    
    @State var isAutomatic: Bool = true
    
    @State var selectedType = "BedTime"
    let types = ["BedTime", "WakeUp"]
    
    @State var detail: String = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Title")
                    .font(.headline)) {
                        TextField("Enter your task title", text: $title)
                    }
                Section(header: Text("Type")
                    .font(.headline)) {
                        Picker(selection: $selectedType, label: EmptyView()) {
                            ForEach(types, id: \.self) {
                                Text($0)
                                    .font(.title3)
                                
                            }
                        }
                        .pickerStyle(.inline)
                    }
                Section(header: Text("Task Duration")
                    .font(.headline)) {
                        HStack {
                            CustomDatePicker(sleepHour: $hour, sleepMinute: $minute)
                                .frame(height: 100.0)
                        }
                    }
                Section(header: Text("Start Time")
                    .font(.headline), footer: Text("If you don't want to set a start time, leave it as automatic.")) {
                        VStack {
                            Toggle("Automatic Arrangement", isOn: $isAutomatic)
                                .padding()
                                .font(.title3)
                            if (!isAutomatic) {
                                HStack {
                                    CustomDatePicker(sleepHour: $startHour, sleepMinute: $startMinute)
                                        .frame(height: 100.0)
                                }
                                .transition(.slide)
                            }
                        }
                    }
                Section(header: Text("Detail")
                    .font(.headline)) {
                        TextField("Enter your task detail", text: $detail)
                    }
            }
            .navigationTitle(Text("New Task"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented.toggle()
                    
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NewTaskButton(title: $title, hour: $hour, minute: $minute, startHour: $startHour, startMinute: $startMinute, isAutomatic: $isAutomatic, selectedType: $selectedType, detail: $detail, isPresented: $isPresented)
                
                }
            }
        
        }
        
        
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(isPresented: .constant(true))
            .environmentObject(UserSettings.shared)
    }
}
