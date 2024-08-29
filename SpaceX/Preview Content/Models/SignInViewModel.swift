//
//  SignInViewModel.swift
//  SpaceX
//
//  Created by Kadir Erlik on 27.08.2024.
//

import SwiftUI
import Foundation
import FirebaseAuth
import RealmSwift

@MainActor

final class SignInViewModel: ObservableObject {
    @Published  var name: String = ""
    @Published  var email: String = ""
    @Published  var password: String = ""
    @Published  var phone: String = ""
    @Published  var country: String = ""
    var countries = ["United States", "Canada", "United Kingdom", "Australia", "Germany", "France", "Japan", "China", "India", "Brazil" , "Turkey"]
    
    var isFormComplete: Bool {
        !name.isEmpty && !email.isEmpty && !password.isEmpty && password.count >= 6 && !phone.isEmpty && !country.isEmpty
    }


    func signIn() {
        guard !email.isEmpty, !password.isEmpty
        else {
            print("No email or password found.")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

