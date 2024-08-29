//
//  Alert.swift
//  SpaceX
//
//  Created by Kadir Erlik on 19.08.2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id: UUID = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    //MARK: - NETWORK ALERTS
    static let invalidData      = AlertItem(title: Text("Server Error"),
                                              message: Text("The data recieved from the server was invalid. Contact Support."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidResponse  = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid response from the server. Please try again."),
                                              dismissButton: .default(Text("OK")))

    static let invalidURL       = AlertItem(title: Text("Server Error"),
                                              message: Text("There was an issue connecting to the server. If this persists contact Support."),
                                              dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                              message: Text("Unable to complete your request please check internet connection."),
                                              dismissButton: .default(Text("OK")))

    
    //MARK: -- ACOUNT ALERTS
    static let invalidForm = AlertItem(title: Text("Invalid Form"),
                                              message: Text("Please ensure all fields are completed."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidEmail = AlertItem(title: Text("Invalid Email"),
                                              message: Text("Please ensure your email is correct."),
                                              dismissButton: .default(Text("OK")))

    static let userSaveSuccess = AlertItem(title: Text("Profile Saved"),
                                              message: Text("Your profile information was successfully saved."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidUserData = AlertItem(title: Text("Profile Error"),
                                              message: Text("There was an error saving or retrieving your profile."),
                                              dismissButton: .default(Text("OK")))
}


