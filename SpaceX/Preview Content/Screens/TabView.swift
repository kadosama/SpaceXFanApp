import SwiftUI

struct TabView: View {
    @State private var selectedTab: Int = 0
    @ObservedObject var viewModel : RocketViewModel
    @ObservedObject  var loginViewModel : LoginViewModel
    @ObservedObject  var signViewModel: SignInViewModel

    
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    switch selectedTab {
                    case 0:
                        RocketsView(loginViewModel: loginViewModel, signViewModel: signViewModel, viewModel : viewModel)
                    case 1:
                        FavouriteRocketsView(viewModel: viewModel, signViewModel: signViewModel, loginViewModel: loginViewModel)
                    case 2:
                        UpcomingLaunchersView(viewModel : viewModel,loginViewModel: loginViewModel, signViewModel: signViewModel)
                    default:
                        Text("Select a tab")
                    }
                    
                    Spacer()
                }
                .background(Color.clear)
                .edgesIgnoringSafeArea(.all)
            }
            VStack {
                Spacer()
                TabBar(selectedTab: $selectedTab)
                    .background(Color.clear)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


