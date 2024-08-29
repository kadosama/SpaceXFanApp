//
//  LauncherTitle.swift
//  SpaceX
//
//  Created by Kadir Erlik on 19.08.2024.
//

import SwiftUI

struct LauncherTitle: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            Text("MARS &")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text("BEYOND")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text("The road making humanity multiplanetary")
                .font(.subheadline)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Spacer().frame(height: 50)
        }
        .padding(.trailing, 25)
        .padding(.top, 160)
        .padding(.horizontal , 5)
        
    }
}

#Preview {
    LauncherTitle()
}
