//
//  NewTaskView.swift
//  DRP_32
//
//  Created by paulodybala on 09/06/2023.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct NewTaskView: View {
    @EnvironmentObject var settings: UserSettings
    
    @State var title: String = ""
    @State var hour: Int = 0
    @State var minute: Int = 15
    @State var startHour: Int = -1
    @State var startMinute: Int = -1
    
    
    @State var isAutomatic: Bool = true
    
    @State var selectedType: String
    let types = ["Bedtime", "Wake Up"]
    
    @State var detail: String = ""
    @Binding var isPresented: Bool
    
    @State private var errorMessage = ""
    @State private var shouldShowValidationAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Title")
                    .font(.headline)) {
                        TextField("Enter your task title", text: $title)
                    }.onTapGesture {
                        self.hideKeyboard()
                      }
                Section(header: Text("Routine Category")
                    .font(.headline)) {
                        Picker(selection: $selectedType, label: EmptyView()) {
                            ForEach(types, id: \.self) {
                                Text($0)
                                    .font(.title3)
                                
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                Section(header: Text("Task Duration")
                    .font(.headline)) {
                        
                        VStack {
                            HStack {
                                CustomDatePicker(sleepHour: $hour, sleepMinute: $minute)
                                    .frame(height: 100.0)
                            }
                            if hour * 60 + minute < 15 {
                                Text("Sleep duration should be at least 15 minutes")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.top, 10)
                            }
                        }
                    }
//                Section(header: Text("Start Time")
//                    .font(.headline), footer: Text("If you don't want to set a start time, leave it as automatic.")) {
//                        VStack {
//                            Toggle("Automatic Arrangement", isOn: $isAutomatic)
//                                .padding()
//                                .font(.title3)
//                            if (!isAutomatic) {
//                                HStack {
//                                    CustomDatePicker(sleepHour: $startHour, sleepMinute: $startMinute)
//                                        .frame(height: 100.0)
//                                }
//                                .transition(.slide)
//                            }
//                        }
//                    }
                
                Section(header: Text("Detail")
                    .font(.headline)) {
                        TextField("Enter your task detail", text: $detail)
                    }.onTapGesture {
                        self.hideKeyboard()
                      }
            }
            .navigationTitle(Text("New Task"))
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $shouldShowValidationAlert, content: { () -> Alert in
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("Okay")))
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented.toggle()
                    
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NewTaskButton(title: $title, hour: $hour, minute: $minute, taskHour: $startHour, taskMinute: $startMinute, isAutomatic: $isAutomatic, selectedType: $selectedType, detail: $detail, isPresented: $isPresented, errorMessage: $errorMessage, shouldShowValidationAlert: $shouldShowValidationAlert)
                
                }
            }
        
        }
        
        
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(selectedType: "Bedtime",isPresented: .constant(true))
            .environmentObject(UserSettings.shared)
    }
}
