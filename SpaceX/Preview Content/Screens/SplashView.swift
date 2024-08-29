import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @StateObject var viewModel = RocketViewModel()
    @StateObject var signViewModel = SignInViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    @AppStorage("signIn") var isSignIn = false

    var body: some View {
        VStack {
            if isActive {
                if !isSignIn {
                    // Navigate to the main app view if the user is signed in
                    TabView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel)
                } else {
                    // Show the login view if the user is not signed in
                    LoginView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel)
                }
            } else {
                VStack {
                    BackgroundImage(imageName: "SplashScreen", width: 0, height: 875)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
