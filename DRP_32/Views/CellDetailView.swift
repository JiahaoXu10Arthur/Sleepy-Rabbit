//
//  CellDetailView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct CellDetailView: View {
    @EnvironmentObject var settings: UserSettings
    @Binding var task: Task
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {                Text(task.title)
                    .font(.largeTitle)
                
                HStack {
                    if task.type == "Bedtime" {
                        Image(systemName: "moon.zzz.fill")
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.orange)
                    }
                    
                    
                    Text("\(task.type) Routine")
                        
                }
                .font(.subheadline)
                
                Spacer()
                
                Divider()
                
                HStack {
                    Text("Duration: \(formatTime(_:task.hour)) : \(formatTime(_:task.minute))")
                    Spacer()
                    
                }
                .font(.headline)
                .foregroundColor(.secondary)
                
                
                Divider()
                
                if task.referenceLinks.count > 0 {
                    Text("Reference Links:")
                        .font(.title2)
  
                    ForEach(task.referenceLinks, id: \.self) { link in
                        Link(destination: URL(string: link)!) {
                            Text(link)
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                        
                    }
                    Divider()
                }
                
                
                if task.detail != "" {
                    Text("Detail:")
                        .font(.title2)
                    Text(task.detail)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Divider()
                }
                
                
            }
            .padding()
        }
        .navigationTitle("Routine Detail")
        
    }
    func formatTime(_ time: Int) -> String {
        let hourString = String(format: "%02d", time)
        return hourString
    }
}

struct CellDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Take a Warm Bath", hour: 0, minute: 30, detail: "This is detail", referenceLinks: ["https://www.youtube.com/watch?v=dQw4w9WgXcQ"], type: "Bedtime")
        CellDetailView(task: .constant(task))
            .environmentObject(UserSettings.shared)
    }
}
