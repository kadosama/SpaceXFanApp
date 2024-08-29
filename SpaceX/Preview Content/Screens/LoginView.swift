import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct LoginView: View {
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @StateObject var authManager = AuthenticationManager()
    @ObservedObject var signViewModel : SignInViewModel


    var body: some View {
        NavigationStack {
            if authManager.isAuthenticated {
                TabView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel)
            } else {
                ZStack {
                    BackgroundImage(imageName: "moon", width: .infinity, height: .infinity)

                    VStack(spacing: 20) {
                        Image("spaceXWhiteLogoWine")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .padding(.top, 200)

                        Spacer()

                        EmailForm(loginViewModel: loginViewModel)

                        PasswordForm(loginViewModel: loginViewModel)

                        HStack {
                            Spacer()
                            Button("Forgot Password") {
                                // Handle forgot password action
                            }
                            .foregroundColor(.gray)
                            .font(.footnote)
                        }

                        LoginButton(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel, authManager: authManager)

                        HStack {
                            Text("or")
                                .foregroundColor(.gray)
                        }

                        SignInButton(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel)
                        
                        
                        Spacer()
                        NavigationLink(destination: SignUpView( viewModel : viewModel , loginViewModel: loginViewModel, signViewModel: signViewModel, authManager: authManager)) {
                            Text("Sign up")
                                .foregroundColor(.white)
                                .font(.footnote)
                                .padding(.bottom, 100)
                        }

                    }
                    .padding(.horizontal, 30)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}
