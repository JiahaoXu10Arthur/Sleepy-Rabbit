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
    @State var referenceLinks: [(String, Bool)] = []
    @State private var deleteIndex = 9999
    
    @State private var notify = "5 minutes before"
    @State private var isShowingSheet = false
    
    let befores = ["At time of event", "5 minutes before", "10 minutes before", "15 minutes before", "20 minutes before", "30 minutes before", "1 hour before"]
    
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
                                    .font(.title)
                                
                            }
                        }
                        .font(.title)
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
                                Text("Task duration should be at least 15 minutes")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.top, 10)
                            }
                            if hour > 5 {
                                Text("Suggestion: Task duration should be less than 6 hours")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                                    .padding(.top, 10)
                                
                            }
                        }
                        HStack {
                            HStack {
                                Image(systemName: "bell.badge")
                                
                                Text("Remind me")
                            }
                            Spacer()
                            
                            Picker("Remind me", selection: $notify) {
                                ForEach(befores, id: \.self) {
                                    Text($0)
                                }
                            }
                            .labelsHidden()
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
                        TextField("Enter your task detail", text: $detail, axis: .vertical)
                            
                    }.onTapGesture {
                        self.hideKeyboard()
                    }
                Section(header: Text("Reference Links")
                    .font(.headline)) {
                        
                        ForEach(0..<referenceLinks.count + 1, id: \.self) { linkIndex in
                            Group {
                                if linkIndex == self.referenceLinks.count {
                                    Button(action: {
                                        self.referenceLinks.insert(("", false), at: 0)
                                    }) {
                                        Text("Add URL")
                                    }
                                    .deleteDisabled(true)
                                } else {
                                    TextField("Enter reference link...", text: Binding<String>(get: {
                                        self.referenceLinks[linkIndex].0
                                    }, set: {
                                        self.referenceLinks[linkIndex].0 = $0
                                    }))
                                    
                                    .foregroundColor(.blue)
                                    .disabled(self.referenceLinks[linkIndex].1)
                                }
                            }
                        }
                        .onDelete { indices in
                            // Perform deletion logic here
                            self.referenceLinks.remove(atOffsets: indices)
                        }
                        
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
                    NewTaskButton(title: $title, hour: $hour, minute: $minute, taskHour: $startHour, taskMinute: $startMinute, isAutomatic: $isAutomatic, selectedType: $selectedType, detail: $detail, isPresented: $isPresented, errorMessage: $errorMessage, shouldShowValidationAlert: $shouldShowValidationAlert, referenceLinks: $referenceLinks, notify: $notify, isShowingSheet: $isShowingSheet)
                    
                }
            }
        }
        
    }
    func canOpenURL(_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                print("url")
                return UIApplication.shared.canOpenURL(url)
            }
        }
        print("url false")
        
        return false
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(selectedType: "Bedtime",isPresented: .constant(true))
            .environmentObject(UserSettings.shared)
    }
}
