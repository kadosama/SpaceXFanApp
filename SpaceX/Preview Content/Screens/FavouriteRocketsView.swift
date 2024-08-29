import SwiftUI
import RealmSwift
import LocalAuthentication

struct FavouriteRocketsView: View {
    
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject  var signViewModel: SignInViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var selectedTab = 1
    @State private var isUnlocked = false

    var body: some View {
        NavigationStack {
            if isUnlocked {
                ZStack(alignment: .topLeading) { // Align content to the top-left
                    BackgroundImage(imageName: "starss", width: .infinity, height: 900)
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        Text("Favorite Rockets")
                            .font(.system(size: 25, weight: .regular))
                            .padding(.top, 100)
                            .padding(.bottom, 20)

                        if viewModel.isLoading {
                            ProgressView("Loading...")
                                .padding(.top, 50)
                        } else {
                            ScrollView {
                                LazyVStack(spacing: 20) {
                                    ForEach(viewModel.favoriteRockets, id: \.self) { rocket in
                                        NavigationLink(
                                            destination: RocketDetailView(
                                                selectedTab: $selectedTab,
                                                viewModel: viewModel,
                                                rocket: rocket
                                            )
                                        ) {
                                            RocketCell(
                                                rocket: rocket,
                                                imageURL: (rocket.flickr_images ?? []).first ?? "test",
                                                title: rocket.name,
                                                title_size: 18,
                                                viewModel: viewModel
                                            )
                                        }
                                        .navigationBarBackButtonHidden(true)
                                    }
                                }
                            }
                            .onAppear {
                                print("Favorite rockets count: \(viewModel.favoriteRockets.count)")
                            }
                        }
                    }
                    
                    VStack {
                        Spacer()
                        TabBar(selectedTab: $selectedTab)
                            .background(Color.clear)
                    }
                    .edgesIgnoringSafeArea(.bottom)

                    // Add your button at the top-left
                    LogOutButton(viewModel: viewModel, signViewModel: signViewModel, loginViewModel: loginViewModel)
                    .padding(.leading, 25) // Positioning the button from the left
                    .padding(.top, 85) // Positioning the button from the top
                }
            } else {
                VStack {
                    Spacer()

                    Text("Please authenticate to view your favorite rockets.")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    authenticate()
                    viewModel.getRockets()
                }
            }
        }
        .navigationBarBackButtonHidden(true) // This hides the back button for the entire view
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to access the favorites tab"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                        viewModel.fetchFavoriteRockets()
                        viewModel.syncFavoriteStatus()// Fetch data only if unlocked
                    } else {
                        print("Authentication failed")
                    }
                }
            }
        } else {
            print("Biometrics not available")
        }
    }
}

#Preview {
    SplashScreen()
}
