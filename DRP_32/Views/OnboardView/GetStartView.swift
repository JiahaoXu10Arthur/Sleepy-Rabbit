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
            StartButtonView()
                .padding(.top, 20)
        } //: BUTTON
    }
}

struct GetStartView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartView()
            .environmentObject(UserSettings.shared)
    }
}
