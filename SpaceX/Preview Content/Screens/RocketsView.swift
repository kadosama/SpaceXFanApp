import SwiftUI
import RealmSwift

struct RocketsView: View {
    
    @ObservedObject  var loginViewModel: LoginViewModel
    @ObservedObject  var signViewModel: SignInViewModel
    @ObservedObject  var viewModel: RocketViewModel
    @State private var selectedTab = 0
    @State private var isFavorite: Bool = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundImage(imageName: "starss", width: .infinity, height: 900)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    LogOutButton(viewModel: viewModel, signViewModel: signViewModel ,loginViewModel: loginViewModel)
                    Spacer()
                }
                .padding(.leading, 12)
                .padding(.top , 70)
                
                Text("SpaceX Rockets")
                    .font(.system(size: 28, weight: .regular))
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .center)

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding(.top, 50)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.rockets, id: \.self) { rocket in
                                NavigationLink(
                                    destination: RocketDetailView(
                                        selectedTab: $selectedTab,
                                        viewModel: viewModel,
                                        rocket: rocket
                                    )
                                ) {
                                    RocketCell(rocket: rocket,
                                               imageURL: (rocket.flickr_images ?? []).first ?? "test",
                                               title: rocket.name,
                                               title_size: 18,
                                               viewModel: viewModel
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                viewModel.getRockets()
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(
                    title: (alertItem.title),
                    message: (alertItem.message),
                    dismissButton: .default(Text("OK"))
                 )
            }
        }
    }
}


