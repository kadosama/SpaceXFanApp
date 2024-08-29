import SwiftUI

struct CancelButton: View {
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var signViewModel: SignInViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var shouldNavigate = false // State variable to control navigation
    
    var body: some View {
        NavigationStack {
            Button(action: {
                shouldNavigate = true // Set the state to true to trigger navigation
            }) {
                Text("Cancel")
                    .foregroundColor(.white)
                    .padding()
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                LoginView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel)
            }
        }
    }
}


