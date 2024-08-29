import SwiftUI

struct LogOutButton: View {
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var signViewModel: SignInViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var shouldNavigate = false

    var body: some View {
        NavigationStack {
            VStack {
                // Updated Button with Image as Label
                Button(action: {
                    do {
                        try loginViewModel.logOut()
                        shouldNavigate = true
                    } catch {
                        print("Failed to log out: \(error)")
                    }
                }) {
                    Label("", systemImage: "rectangle.portrait.and.arrow.right") // Button with text and image
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular))
                }

                // Use the new navigationDestination approach
                NavigationLink(value: shouldNavigate) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                LoginView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel)
            }
        }
    }
}
