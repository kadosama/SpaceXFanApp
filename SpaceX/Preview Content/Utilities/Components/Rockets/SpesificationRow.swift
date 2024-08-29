//
//  SpesificationRow.swift
//  SpaceX
//
//  Created by Kadir Erlik on 14.08.2024.
//

import SwiftUI

struct SpesificationRow: View {
    
    let title : String
    let value : String
    
    var body: some View {
        
       HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
            Spacer()
            Text(value)
                .foregroundColor(.white)
                .font(.system(size: 16))
        }
        Divider()
            .padding(.vertical, 4)
    }
}

