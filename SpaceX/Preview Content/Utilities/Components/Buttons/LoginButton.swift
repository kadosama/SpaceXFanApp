import SwiftUI
import FirebaseAuth

struct LoginButton: View {
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject var signViewModel : SignInViewModel
    @ObservedObject var authManager: AuthenticationManager
    @State private var shouldNavigate = false
    @State private var showAlert = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    loginViewModel.login(email: loginViewModel.email, password: loginViewModel.password) { success in
                        if success {
                            shouldNavigate = true
                        } else {
                            errorMessage = loginViewModel.errorMessage!
                            showAlert = true
                        }
                    }
                }) {
                    Text("Log in")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Failed"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }

                NavigationLink(value: shouldNavigate) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                TabView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel)
            }
        }
    }
}
