import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject  var signViewModel: SignInViewModel
    @ObservedObject  var authManager: AuthenticationManager
    @Environment(\.dismiss) var dismiss
    @State private var showCountryPicker = false
    @State private var navigateToPrivacyAndConditions = false

    var body: some View {
            ZStack {
                // Background image
                BackgroundImage(imageName: "starss", width: .infinity, height: .infinity)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    // Top Bar
                    HStack {
                        BackButton() // Assuming this is your custom back button
                        Spacer().frame(width: 100)
                        Text("Sign Up")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                        CancelButton(viewModel: viewModel, signViewModel: signViewModel, loginViewModel: loginViewModel)
                    }
                    .padding(.top, 75)
                    .padding(.leading, 40)
                    
                    // Step Indicator
                    HStack(spacing: 70) {
                        Text("1")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding(10)
                            .background(Circle().stroke(Color.green, lineWidth: 1))
                        
                        Text("2")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Circle().stroke(Color.white, lineWidth: 1))
                        
                        Text("3")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Circle().stroke(Color.white, lineWidth: 1))
                        
                   
                    }
                    .padding(.vertical, 15)
                    
                    Spacer()
                    
                    // Form fields
                    VStack(spacing: 16) {
                        Spacer().frame(height: 20)
                        CustomTextField(iconName: "person.circle", placeholder: "Enter your name", text: $signViewModel.name)
                        CustomTextField(iconName: "envelope", placeholder: "Enter your e-mail address", text: $signViewModel.email)
                        CustomTextField(iconName: "lock", placeholder: "Enter your password", text: $signViewModel.password, isSecure: true)
                        
                        Text("Password needs to be more than 6 characters")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        CustomTextField(iconName: "phone", placeholder: "Enter your phone number", text: $signViewModel.phone)
                        
                        // Country Picker styled as a text field
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.white)
                            
                            // Custom button to display selected country
                            Button(action: {
                                showCountryPicker = true // Show the confirmation dialog when tapped
                            }) {
                                Text(signViewModel.country.isEmpty ? "Select your country" : signViewModel.country)
                                    .foregroundColor(.white) // White text color
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .confirmationDialog("Select your country", isPresented: $showCountryPicker, titleVisibility: .visible) {
                                ForEach(signViewModel.countries, id: \.self) { country in
                                    Button(country) {
                                        signViewModel.country = country // Update selection
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .frame(width: 350, height: 40)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(15)
                        
                        Spacer()
                        
                        // Continue button with navigation
                        Button(action: {
                            // Validate the form and navigate if valid
                            if signViewModel.isFormComplete {
                                navigateToPrivacyAndConditions = true
                                signViewModel.signIn()
                            }
                        }) {
                            Text("Continue")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 225, height: 45)
                                .background(signViewModel.isFormComplete ? Color.green : Color.gray)
                                .cornerRadius(20)
                        }
                        .disabled(!signViewModel.isFormComplete) // Disable button when form is incomplete
                        .padding(.horizontal)
                        .padding(.bottom, 100)
                    }
                    .padding()
                }
                .foregroundColor(.white)
                .navigationBarBackButtonHidden(true) // Ensure back button is hidden here
                .navigationDestination(isPresented: $navigateToPrivacyAndConditions) {
                    PrivacyAndConditionsView(viewModel : viewModel , loginViewModel: loginViewModel, signViewModel: signViewModel ) // Destination view
                }
            }
        }
    }

#Preview {
    SplashScreen()
}
