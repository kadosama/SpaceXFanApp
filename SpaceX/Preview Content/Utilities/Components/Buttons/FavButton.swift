import SwiftUI
import RealmSwift

struct FavButton: View {
    @ObservedObject var viewModel: RocketViewModel
    let rocket: Rocket

    var body: some View {
        Button(action: {
            viewModel.toggleFavorite(for:rocket)
        }) {
            Image(rocket.isFavorite ? "whitefav" : "favorites")
                
        }
    }
}
