import SwiftUI

struct LaunchListCell: View {
    let launch: Launch
    let index: Int
    let onExploreTapped: () -> Void
    
    private let imageNames = ["image1", "image2", "image3"]
    
    private var isLeftAligned: Bool {
        return index % 3 == 1
    }
    
    var body: some View {
        ZStack(alignment: isLeftAligned ? .leading : .trailing) {
            Image(imageNames[index % imageNames.count])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 350)
                .clipped()
                .blendMode(.screen)
                //.shadow(radius: 5)
            
            VStack(alignment: isLeftAligned ? .leading : .trailing, spacing: 8) {
                Text(launch.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(isLeftAligned ? .leading : .trailing, 20)
                    .padding(.top, 0)
                
                Text("Flight Number: \(launch.flightNumber)")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(isLeftAligned ? .leading : .trailing, 20)
                
                CustomButton(
                    title: "Explore",
                    width: 80,
                    height: 15,
                    enabledColor: .gray.opacity(0.9),
                    font: Font.system(size: 14, weight: .semibold),
                    action: {
                        onExploreTapped()
                    }
                )
                .padding(isLeftAligned ? .leading : .trailing, 20)
                .padding(.top, 10)
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width - 80, height: 320, alignment: isLeftAligned ? .leading : .trailing)
            .padding(isLeftAligned ? .leading : .trailing, 20)
            
            Spacer()
        }
        .frame(width: 359, height: 320)
        //.padding(.horizontal, 20)
    }
}


