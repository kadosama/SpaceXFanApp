import SwiftUI

struct RocketDetailView: View {
    @Binding var selectedTab: Int
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: RocketViewModel
    let rocket: Rocket?
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundImage(imageName: "starss", width: .infinity, height: .infinity)
                    .blur(radius: 2)
                
                if let rocket = rocket {
                    ScrollView {
                        VStack(spacing: 0) {
                            HStack {
                                RocketTitle(title: rocket.name, size: 20)
                            }
                            .padding(.top, 28)
                            
                            Spacer().frame(height: 30)
                            
                            RocketCell( rocket: rocket,
                                        imageURL: (rocket.flickr_images ?? []).first ?? "test",
                                        title: rocket.name,
                                        title_size: 18,
                                        viewModel: viewModel
                            )
                            
                            RocketDescription(description: rocket.description)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                SpesificationView(rocket: rocket)
                            }
                            .padding(.horizontal)
                            
                            RocketGallery(rocket: rocket) // ı have a problem
                            
                            
                        }
                        .padding(.bottom, 16)
                    }
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            BackButton()
                        }
                    }
                } else {
                    Text("Rocket data is unavailable.")
                        .foregroundColor(.white)
                }

                VStack {
                    Spacer()
                    TabBar(selectedTab: $selectedTab)
                        .background(Color.clear)
                        .padding(.bottom,-15)
                }
                .edgesIgnoringSafeArea(.all)
            }
            
        }
    }
}
