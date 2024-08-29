//
//  LauncherData.swift
//  SpaceX
//
//  Created by Kadir Erlik on 19.08.2024.
//

import SwiftUI

struct LauncherData: View {
    var body: some View {
        HStack(spacing: 40) {
            VStack {
                Text("6")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                
                Text("MONTHS")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity) // Ensures each VStack takes the same width
            
            VStack {
                Text("2")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                
                Text("MOONS")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity) // Ensures each VStack takes the same width
            
            VStack {
                Text("14")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                
                Text("ORBITING SATELLITES")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity) // Ensures each VStack takes the same width
        }
        
    }
    
}



#Preview {
    LauncherData()
}
