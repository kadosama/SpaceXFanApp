import SwiftUI

struct LauncherDetailView: View {
    @Binding var selectedTab: Int
    let launch: Launch
    let backgroundImageName: String
    let index: Int
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject var signViewModel : SignInViewModel


    private var rocketName: String {
        var name = "Unknown Rocket"
        for rocket in viewModel.rockets {
            if rocket.id == launch.rocket {
                name = rocket.name
                break
            }
        }
        return name
    }
    private var isLeftAligned: Bool {
        return index % 3 == 1
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image
                BackgroundImage(imageName: "starss", width: 0, height: 875)
                
                // Mars Image
                Image(backgroundImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width , height: 350)
                    .clipped()
                    .blendMode(.screen)
                    .padding(.bottom, 250)
                
                // Main Content
                VStack {
                    Spacer().frame(height: 150)
                    
                    VStack(alignment: isLeftAligned ? .leading : .trailing, spacing: 5) {
                        Text(launch.name)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Flight Number: \(launch.flightNumber)")
                            .font(.system(size: 22, weight: .regular))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity, alignment: isLeftAligned ? .leading : .trailing)
                    .padding(isLeftAligned ? .leading : .trailing, 10)
                    
                    Spacer().frame(height: 50)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text(extractDay(from: launch.dateLocal))
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(.white)
                            Text("DAY")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        VStack {
                            Text(extractMonth(from: launch.dateLocal))
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(.white)
                            Text("MONTH")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        VStack {
                            Text(extractYear(from: launch.dateLocal))
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(.white)
                            Text("YEAR")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: isLeftAligned ? .leading : .trailing)
                    .padding(isLeftAligned ? .leading : .trailing, 10)
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        TabBar(selectedTab: $selectedTab)
                            .background(Color.clear)
                            .padding(.bottom, 0)
                            .edgesIgnoringSafeArea(.bottom)
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("Upcoming Launchers", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: UpcomingLaunchersView(viewModel: viewModel,loginViewModel: loginViewModel, signViewModel: signViewModel)) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 14, height: 23)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
    
    private func extractDay(from dateString: String) -> String {
        let components = dateString.split(separator: "-")
        return String(components[2].prefix(2))
    }
    
    private func extractMonth(from dateString: String) -> String {
        let components = dateString.split(separator: "-")
        return String(components[1])
    }
    
    private func extractYear(from dateString: String) -> String {
        let components = dateString.split(separator: "-")
        return String(components[0])
    }
}

#Preview {
    SplashScreen()
}
