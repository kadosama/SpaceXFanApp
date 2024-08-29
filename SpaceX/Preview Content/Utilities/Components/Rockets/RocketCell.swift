import SwiftUI

struct RocketCell: View {
    let rocket : Rocket
    let imageURL: String
    let title: String
    let title_size: CGFloat
    @ObservedObject var viewModel: RocketViewModel

    var body: some View {
        VStack {
            HStack {
                RocketTitle(title: title, size: title_size)
                Spacer()
                FavButton(viewModel: viewModel , rocket : rocket)
                    .padding()
                    .frame(width: 30)
            }
            
            RocketRemoteImage(urlString: imageURL)
                .aspectRatio(contentMode: .fill)
                .frame(width: 210, height: 125)
                .padding(.bottom, 20)
        }
        .padding()
        .frame(width: 360.0, height: 225.0)
        .background(Color.white.opacity(0.1))
        .cornerRadius(16.0)
    }
}


    
