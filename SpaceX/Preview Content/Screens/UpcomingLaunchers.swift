import SwiftUI

struct UpcomingLaunchersView: View {
    @StateObject private var launchViewModel = LaunchViewModel()
    @State private var selectedLaunch: Launch? = nil
    @State private var isDetailPresented = false
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject var signViewModel : SignInViewModel

    

    @State private var selectedTab: Int = 2

    var body: some View {
        NavigationStack {
            ZStack {
                // Background image
                BackgroundImage(imageName: "starss", width: .infinity, height: .infinity)
                    .edgesIgnoringSafeArea(.all) // Ensure the background image covers the entire screen
                
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        ScrollView {
                            VStack(spacing: 40) {
                                ForEach(launchViewModel.launches.indices, id: \.self) { index in
                                    LaunchListCell(
                                        launch: launchViewModel.launches[index],
                                        index: index,
                                        onExploreTapped: {
                                            selectedLaunch = launchViewModel.launches[index]
                                            isDetailPresented = true
                                        }
                                    )
                                    .padding(.horizontal, 20)
                                }
                            }
                            .padding(.top, 20)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height) // Full height and width

                        TabBar(selectedTab: $selectedTab)
                            .background(Color.clear)
                            .padding(.bottom, 110)
                            .edgesIgnoringSafeArea(.bottom) // Ensures the tab bar aligns at the bottom
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .ignoresSafeArea(.all)// Full height and width
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("Upcoming Launchers", displayMode: .inline)
                .padding(.top, 200) // Adjusted padding to make sure content fits well
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        // Back button or any custom button can be placed here
                    }
                }

                // Add button at the top-left corner
                VStack {
                    HStack {
                        LogOutButton(viewModel: viewModel, signViewModel: signViewModel, loginViewModel: loginViewModel)
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.leading, 12) // Adjust the padding as needed
                .padding(.top, 30) // Adjust the padding as needed
            }
            .onAppear {
                launchViewModel.fetchUpcomingLaunches()
            }
            .navigationDestination(isPresented: $isDetailPresented) {
                if let selectedLaunch = selectedLaunch {
                    if let launchIndex = launchViewModel.launches.firstIndex(where: { launch in launch.id == selectedLaunch.id }) {
                        LauncherDetailView(
                            selectedTab: $selectedTab,
                            launch: selectedLaunch,
                            backgroundImageName: "image\(launchIndex % 3 + 1)",
                            index: launchIndex,
                            viewModel: viewModel,
                            loginViewModel: loginViewModel,
                            signViewModel: signViewModel
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
