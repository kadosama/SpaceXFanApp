//
//  AunthViewmodel.swift
//  SpaceX
//
//  Created by Kadir Erlik on 23.08.2024.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

final class AuthenticationManager : ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    static let shared = AuthenticationManager()
   
     init() {checkAuthentication()}
    
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
    func checkAuthentication() {
           if Auth.auth().currentUser != nil {
               isAuthenticated = true
           } else {
               isAuthenticated = false
           }
       }
       
    
    func signOut() throws {
        try Auth.auth().signOut()
        isAuthenticated = false
    }
}

