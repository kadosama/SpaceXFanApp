//
//  PasswordForm.swift
//  SpaceX
//
//  Created by Kadir Erlik on 14.08.2024.
//

import SwiftUI

struct PasswordForm: View {
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.gray)
            if loginViewModel.isPasswordVisible {
                TextField("Password", text: $loginViewModel.password)
                    .foregroundColor(.white)
            } else {
                SecureField("Password", text: $loginViewModel.password)
                    .foregroundColor(.white)
            }
            Button(action: {
                loginViewModel.isPasswordVisible.toggle()
            }) {
                Image(systemName: loginViewModel.isPasswordVisible ? "eye" : "eye.slash")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(white: 0.15))
        .cornerRadius(8)
    }
}

