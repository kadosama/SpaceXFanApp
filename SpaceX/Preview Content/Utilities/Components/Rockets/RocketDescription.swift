//
//  RocketDescription.swift
//  SpaceX
//
//  Created by Kadir Erlik on 15.08.2024.
//

import SwiftUI

struct RocketDescription: View {
    let description : String
    var body: some View {
        Text(description)
            .foregroundColor(.white)
            .font(.system(size: 14))
            .multilineTextAlignment(.center)
            .padding()
    }
}
