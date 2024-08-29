import SwiftUI

struct CustomButton: View {
    let title: String
    let width: CGFloat
    let height: CGFloat
    let enabledColor: Color
    let font: Font
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .frame(width: width, height: height)
                .background(enabledColor)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}
