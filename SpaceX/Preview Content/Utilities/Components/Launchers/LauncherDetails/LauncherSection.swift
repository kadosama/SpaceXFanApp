//
//  WhyMarsSection.swift
//  SpaceX
//
//  Created by Kadir Erlik on 19.08.2024.
//

import SwiftUI

struct LauncherSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("WHY MARS?")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
            
            Text("""
                                At an average distance of 140 million miles, Mars is one of Earth's closest habitable neighbors. Mars is about half again as far from the Sun as Earth is, so it still has decent sunlight. It is a little cold, but we can warm it up. Its atmosphere is primarily CO2 with some nitrogen and argon and a few other trace elements, which means that we can grow plants on Mars just by compressing the atmosphere. Gravity on Mars is about 38% of that of Earth, so you would be able to lift heavy things and bound around. Furthermore, the day is remarkably close to that of Earth.
                                """)
            .font(.system(size: 16))
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal)
    }
}

#Preview {
    LauncherSection()
}
