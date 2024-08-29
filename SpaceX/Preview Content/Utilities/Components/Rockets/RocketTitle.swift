//
//  SpacexHeader.swift
//  SpaceX
//
//  Created by Kadir Erlik on 13.08.2024.
//

import SwiftUI

struct RocketTitle: View {
    let title: String
    let size: CGFloat
    
  
    
    var body: some View {
        Text(title)
            .font(Font.custom("Nasalization", size: size))
            .foregroundColor(Color(red: 88.0 / 255.0, green: 251.0 / 255.0, blue: 200.0 / 255.0))
            
                       
    }
}

#Preview {
    RocketTitle(title: "KAADIR",size: 30)
}
