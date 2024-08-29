import SwiftUI

struct CustomTextField: View {
    var iconName: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    @State private var isPasswordVisible: Bool = false

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.white)
            
            if isSecure && !isPasswordVisible {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
                    .padding()
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
                    .padding()
            }

            if isSecure {
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal)
        .background(Color.black.opacity(0.3))
        .cornerRadius(15)
    }
}

