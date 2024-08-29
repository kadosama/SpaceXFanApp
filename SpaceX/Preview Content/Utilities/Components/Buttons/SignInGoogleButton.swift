import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct SignInButton: View {
    @State private var isSignedIn = false
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject var signViewModel : SignInViewModel

    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                    
                    // Create Google Sign In configuration object.
                    let config = GIDConfiguration(clientID: clientID)
                    GIDSignIn.sharedInstance.configuration = config
                    
                    // Start the sign-in flow!
                    GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { user, error in
                        guard error == nil else {
                            return
                        }
                        
                        guard let user = user?.user,
                              let idToken = user.idToken?.tokenString else {
                            return
                        }
                        
                        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                       accessToken: user.accessToken.tokenString)
                        
                        Auth.auth().signIn(with: credential) { result, error in
                            guard error == nil else {
                                return
                            }
                            
                            UserDefaults.standard.set(true, forKey: "signIn")
                            isSignedIn = true // Update state to trigger navigation
                        }
                    }
                }) {
                    HStack {
                        Image("icons8-google-50")
                            .resizable()  // Make sure the image is resizable
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20) // Adjust the size to fit the text
                            .foregroundColor(.white)
                        Text("Sign in with Google")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
                }
                .padding(.top , 10)

                // Navigation triggered by state change
                NavigationLink(value: isSignedIn) {
                    EmptyView()
                }
                .navigationDestination(isPresented: $isSignedIn) {
                    TabView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SplashScreen()
}
