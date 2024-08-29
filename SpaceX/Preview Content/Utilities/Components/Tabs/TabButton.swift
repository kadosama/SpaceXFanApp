import SwiftUI

struct TabButton: View {
    let name: String
    let isSelected: Bool
    let destination: AnyView 
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                Image(name)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .green : .white)
                
                if isSelected {
                    Text(name.capitalized)
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
        }
    }
}
