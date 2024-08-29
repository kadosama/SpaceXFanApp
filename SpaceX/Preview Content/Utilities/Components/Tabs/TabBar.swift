import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int
    @StateObject var viewModel = RocketViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var signViewModel = SignInViewModel()


    
    
    var body: some View {
        HStack {
            TabButton(
                name: "rockets",
                isSelected: selectedTab == 0,
                destination: AnyView(TabView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel))
            )
            .onTapGesture {
                selectedTab = 0
            }
            
            TabButton(
                name: "favorites",
                isSelected: selectedTab == 1,
                destination: AnyView(FavouriteRocketsView(viewModel: viewModel, signViewModel: signViewModel,loginViewModel: loginViewModel))
            )
            .onTapGesture {
                selectedTab = 1
            }
            
            TabButton(
                name: "upcoming",
                isSelected: selectedTab == 2,
                destination: AnyView(UpcomingLaunchersView(viewModel: viewModel,loginViewModel: loginViewModel, signViewModel: signViewModel))
            )
            .onTapGesture {
                selectedTab = 2
            }
        }
        .frame(height: 55)
        .background(Color.gray.opacity(0.3))  // Light gray background for the tab bar
        .cornerRadius(20)
        .padding(.horizontal, 22)
        .padding(.bottom, 80)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBar(selectedTab: .constant(0))
}
