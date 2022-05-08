//
//  StatusBarBackground.swift
//  SwipeableModal
//
//  Created by Polarizz on 5/7/22.
//

import SwiftUI

struct StatusBarBackground: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Color(.systemBackground)
                    .frame(height: geo.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.top)
                
                Spacer()
            }
        }
    }
}
