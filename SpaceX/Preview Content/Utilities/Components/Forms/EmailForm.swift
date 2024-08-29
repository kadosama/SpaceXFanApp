//
//  EmailForm.swift
//  SpaceX
//
//  Created by Kadir Erlik on 14.08.2024.
//

import SwiftUI

struct EmailForm: View {
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(.gray)
            TextField("E-mail", text: $loginViewModel.email)
                .foregroundColor(.white)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
        }
        .padding()
        .background(Color(white: 0.15))
        .cornerRadius(8)
    }
}


