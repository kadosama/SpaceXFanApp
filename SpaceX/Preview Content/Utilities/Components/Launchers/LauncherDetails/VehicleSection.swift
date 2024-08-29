//
//  VehicleSection.swift
//  SpaceX
//
//  Created by Kadir Erlik on 19.08.2024.
//

import SwiftUI

struct VehicleSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("VEHICLE")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
            
            Text("STARSHIP")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(.white)
            
            Text("""
                                Starship will be the world’s most powerful launch vehicle ever developed, with the ability to carry in excess of 100 metric tonnes to Earth orbit. Drawing on an extensive history of launch vehicle and engine development programs, SpaceX has been rapidly iterating on the design of Starship with orbital-flight targeted for 2020.
                                """)
            .font(.system(size: 16))
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal)
    }
}

#Preview {
    VehicleSection()
}
