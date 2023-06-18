//
//  EditCellDetail.swift
//  DRP_32
//
//  Created by paulodybala on 14/06/2023.
//

import SwiftUI

struct EditCellDetail: View {
    @EnvironmentObject var settings: UserSettings

    @State var title: String = ""
    @State var hour: Int
    @State var minute: Int
    @State var startHour: Int
    @State var startMinute: Int
    
    @State var selectedType: String
    let types = ["Bedtime", "Wake Up"]
    
    @State var detail: String
    @Binding var isPresented: Bool
    
    @State private var errorMessage = ""
    @State private var shouldShowValidationAlert = false
    @State var referenceLinks: [(String, Bool)] = []
    @State private var deleteIndex = 9999
    
    @State private var notify = "5 minutes before"
    
    var task: Task
    

    let befores = ["At time of event", "5 minutes before", "10 minutes before", "15 minutes before", "20 minutes before", "30 minutes before", "1 hour before"]
    
    init(task: Task, isPresented: Binding<Bool>) {
        self.task = task
        _title = State(initialValue: task.title)
        _detail = State(initialValue: task.detail)
        _selectedType = State(initialValue: task.type)
        _hour = State(initialValue: task.hour)
        _minute = State(initialValue: task.minute)
        _startHour = State(initialValue: task.startHour)
        _startMinute = State(initialValue: task.startMinute)
        _notify = State(initialValue: {switch task.before {
        case 0:
            return "At time of event"
        case 5:
            return "5 minutes before"
        case 10:
            return "10 minutes before"
        case 15:
            return "15 minutes before"
        case 20:
            return "20 minutes before"
        case 30:
            return "30 minutes before"
        case 60:
            return "1 hour before"
        default:
            return "5 minutes before"
        }}())
        _referenceLinks = State(initialValue: {task.referenceLinks.map {($0, true)}}())
        _isPresented = isPresented
        
    }
    
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
                                EditPicker(sleepHour: $hour, sleepMinute: $minute)
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
                                    Text("Add Reference")
                                }
                                .deleteDisabled(true)
                            } else {
                                TextField("Enter reference link...", text: Binding<String>(get: {
                                    self.referenceLinks[linkIndex].0
                                }, set: {
                                    self.referenceLinks[linkIndex].0 = $0
                                }))
                                
                                .foregroundColor(self.canOpenURL(self.referenceLinks[linkIndex].0) ? nil : .red)
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
            
            .navigationTitle(Text("Edit Task"))
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
                    EditDetailButtonView(title: $title, hour: $hour, minute: $minute, taskHour: $startHour, taskMinute: $startMinute, selectedType: $selectedType, detail: $detail, isPresented: $isPresented, errorMessage: $errorMessage, shouldShowValidationAlert: $shouldShowValidationAlert, referenceLinks: $referenceLinks, notify: $notify, task: task, original: task)
                    
                }
            }
        }
        
    }
    func canOpenURL(_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                
                return UIApplication.shared.canOpenURL(url)
            }
        }
        
        return false
    }
    
}

struct EditCellDetail_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Take a Warm Bath", hour: 0, minute: 30, startHour: 21, startMinute: 30, detail: "This is detail", referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime")
        EditCellDetail(task: task, isPresented: .constant(true))
            .environmentObject(UserSettings.shared)
    }
}
