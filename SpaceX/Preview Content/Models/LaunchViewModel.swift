//
//  LauncherViewmodel.swift
//  SpaceX
//
//  Created by Kadir Erlik on 21.08.2024.
//

import SwiftUI

final class LaunchViewModel: ObservableObject {
    @Published var launches: [Launch] = []
    @Published var isLoading: Bool = false
    @Published var alertItem: AlertItem?

    func fetchUpcomingLaunches() {
        isLoading = true
        NetworkManager.shared.getUpcomingLaunches { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let launchesData):
                    self.launches = launchesData
                case .failure(let error):
                    print("[ERROR] Failed fetching launches: \(error.localizedDescription)")
                    self.alertItem = AlertItem(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
