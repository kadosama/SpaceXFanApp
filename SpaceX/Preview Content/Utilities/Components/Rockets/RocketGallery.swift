//
//  RocketGallery.swift
//  SpaceX
//
//  Created by Kadir Erlik on 15.08.2024.
//
import SwiftUI

struct RocketGallery: View {
    let rocket: Rocket
    
    // Define the grid layout
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 16) {
                if let flickrImages = rocket.flickr_images {
                    ForEach(flickrImages, id: \.self) { imageURL in
                        RocketRemoteImage(urlString: imageURL)
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
        }
    }
}
