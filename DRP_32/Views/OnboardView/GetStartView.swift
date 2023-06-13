//
//  GetStartView.swift
//  DRP_32
//
//  Created by paulodybala on 13/06/2023.
//

import SwiftUI

struct GetStartView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        VStack {
          
          Spacer()
          Text("Eveything is ready")
            .font(.system(size: 44, weight: .semibold))
            .padding(.bottom)
          
          Text("Let's jump into the rabbit hole!")
              .padding()
          
            StartButtonView()
                .padding(.top, 20)
          
          Spacer()
        } //: BUTTON
    }
}

struct GetStartView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartView()
            .environmentObject(UserSettings.shared)
    }
}
