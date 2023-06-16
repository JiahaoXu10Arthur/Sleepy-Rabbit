//
//  ChooseView.swift
//  DRP_32
//
//  Created by paulodybala on 16/06/2023.
//

import SwiftUI

struct ChooseView: View {
    @EnvironmentObject var settings: UserSettings
    @State var chosenUniversity: String = "Imperial College London"
    var body: some View {
        NavigationView{
            Form{
                Picker("University List", selection: $chosenUniversity){
                    ForEach(settings.universites, id: \.self){
                        Text($0)
                            
                    }
                }
                .pickerStyle(.inline)
            }
            .navigationTitle("Choose Your University")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        settings.chosenUniversity = chosenUniversity
                    }, label: {
                        Text("Save")
                    })
                }
            }
        
        }
    }
}

struct ChooseView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseView()
            .environmentObject(UserSettings.shared)
    }
}
