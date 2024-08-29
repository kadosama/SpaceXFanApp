//
//  Image.swift
//  SpaceX
//
//  Created by Kadir Erlik on 13.08.2024.
//

import SwiftUI

struct BackgroundImage: View {
    let imageName: String
    let width : CGFloat
    let height : CGFloat

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .ignoresSafeArea(.all)
            
    }
}


#Preview {
    BackgroundImage(imageName: "starss", width: .infinity, height: 1000)
}
