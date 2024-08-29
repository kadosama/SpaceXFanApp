import SwiftUI

struct SpesificationView: View {
    
    let rocket: Rocket
    
    var body: some View {
        VStack {
            Divider()
            SpesificationRow(
                title: "Height",
                value: "\(rocket.height?.meters ?? 0.0) m / \(rocket.height?.feet ?? 0.0) ft"
            )
            Divider()
            SpesificationRow(
                title: "Diameter",
                value: "\(rocket.diameter?.meters ?? 0.0) m / \(rocket.diameter?.meters ?? 0.0) ft"
            )
            Divider()
            SpesificationRow(
                title: "Mass",
                value: "\(rocket.mass?.kg ?? 0.0) kg / \(rocket.mass?.lb ?? 0.0) lb"
            )
            Divider()
            if let leoPayload = rocket.payload_weights?.first(where: { $0.id == "leo" }) {
                SpesificationRow(
                    title: "Payload to LEO",
                    value: "\(leoPayload.kg ?? 0.0) kg / \(leoPayload.lb ?? 0.0) lb"
                )
                Divider()
            }
            if let gtoPayload = rocket.payload_weights?.first(where: { $0.id == "gto" }) {
                SpesificationRow(
                    title: "Payload to GTO",
                    value: "\(gtoPayload.kg ?? 0.0) kg / \(gtoPayload.lb ?? 0.0) lb"
                )
                Divider()
            }
            if let marsPayload = rocket.payload_weights?.first(where: { $0.id == "mars" }) {
                SpesificationRow(
                    title: "Payload to Mars",
                    value: "\(marsPayload.kg ?? 0.0) kg / \(marsPayload.lb ?? 0.0) lb"
                )
                Divider()
            }
        }
    }
}


