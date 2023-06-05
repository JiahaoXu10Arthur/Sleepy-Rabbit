//
//  BreathingView.swift
//  DRP_32
//
//  Created by 蒋伯源 on 2023/5/31.
//

import SwiftUI

struct CommunityView: View {
    @State var showFab = true
    @State var scrollOffset:CGFloat = 0.0
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        ScrollView {
            
            PostButtons()
            
            Divider()
            
            TipList()
            
                .background(GeometryReader {
                    return Color.clear.preference(key: ViewOffsetKey.self,
                                           value: -$0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) { offset in
                    withAnimation {
                        if offset > 50 {
                            showFab = offset < scrollOffset
                        } else  {
                            showFab = true
                        }
                    }
                    scrollOffset = offset
                }
        }
        
        .refreshable {
            modelData.fetchData()
        }
        
        .coordinateSpace(name: "scroll")
        .overlay(
            showFab ?
                createFab()
                : nil
            , alignment: Alignment.bottomTrailing)
                
    }
    
    fileprivate func createFab() -> some View {
            return Button(action: {
            }, label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40, alignment: .center)
            })
            .padding(8)
            .background(Color.blue)
            .cornerRadius(15)
            .padding(8)
            .shadow(radius: 3,
                    x: 3,
                    y: 3)
            .transition(.scale)
        }
    
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
            .environmentObject(ModelData.shared)
    }
}
