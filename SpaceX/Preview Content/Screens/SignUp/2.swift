import SwiftUI

struct PrivacyAndConditionsView: View {
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject var signViewModel : SignInViewModel
    @State private var isMembershipAccepted: Bool = false
    @State private var isPrivacyPolicyAccepted: Bool = false
    @State private var navigateToNextScreen: Bool = false // State to control navigation
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
            ZStack {
                // Background Image
                BackgroundImage(imageName: "starss", width: .infinity, height: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Header
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Text("Privacy and Conditions")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Just to align the text in the center
                        Spacer().frame(width: 44)
                    }
                    .padding(.top, 20)
                    
                    // Progress Indicators as "1 2 3 4"
                    HStack(spacing: 70) {
                        Text("1")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding(10)
                            .background(Circle().stroke(Color.green, lineWidth: 1))
                        
                        Text("2")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding(10)
                            .background(Circle().stroke(Color.green, lineWidth: 1))
                        
                        Text("3")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Circle().stroke(Color.white, lineWidth: 1))
                        
                       
                    }
                    .padding(.vertical, 15)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Membership Agreement")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            ScrollView {
                                Text("1. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis porta orci, id semper neque. Morbi vehicula odio sit amet libero pretium dapibus. Sed vel feugiat dolor. Nullam at eros nibh. Duis vehicula venenatis massa vel mattis. Suspendisse venenatis suscipit elit, id tincidunt sapien eleifend eu. Proin rhoncus semper arcu id rutrum. Donec sit amet magna ultrices massa molestie laoreet sed vitae risus.\n\n2. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis porta orci, id semper neque. Morbi vehicula odio sit amet libero pretium dapibus. Sed vel feugiat dolor. Nullam at eros nibh. Duis vehicula venenatis massa vel mattis. Suspendisse venenatis suscipit elit, id tincidunt sapien eleifend eu. Proin rhoncus semper arcu id rutrum. Donec sit amet magna ultrices massa molestie laoreet sed vitae risus.")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .frame(height: 200) // Set the desired height for the scrollable content
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        Spacer().frame(height : 20)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Privacy Policy")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            ScrollView {
                                Text("1. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis porta orci, id semper neque. Morbi vehicula odio sit amet libero pretium dapibus. Sed vel feugiat dolor. Nullam at eros nibh. Duis vehicula venenatis massa vel mattis. Suspendisse venenatis suscipit elit, id tincidunt sapien eleifend eu. Proin rhoncus semper arcu id rutrum. Donec sit amet magna ultrices massa molestie laoreet sed vitae risus.\n\n2. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis porta orci, id semper neque. Morbi vehicula odio sit amet libero pretium dapibus. Sed vel feugiat dolor. Nullam at eros nibh. Duis vehicula venenatis massa vel mattis. Suspendisse venenatis suscipit elit, id tincidunt sapien eleifend eu. Proin rhoncus semper arcu id rutrum. Donec sit amet magna ultrices massa molestie laoreet sed vitae risus.")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .frame(height: 200) // Set the desired height for the scrollable content
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Checkbox and Continue Button
                    VStack {
                        Toggle(isOn: $isMembershipAccepted) {
                            Text("I have read and accept to Membership Contract.")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        Toggle(isOn: $isPrivacyPolicyAccepted) {
                            Text("I have read and accept to Privacy Policy.")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        Button(action: {
                            // Trigger navigation
                            if isMembershipAccepted && isPrivacyPolicyAccepted {
                                navigateToNextScreen = true
                            }
                        }) {
                            Text("Continue")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .opacity(isMembershipAccepted && isPrivacyPolicyAccepted ? 1.0 : 0.5)
                        }
                        .disabled(!isMembershipAccepted || !isPrivacyPolicyAccepted)
                        .padding()
                    }
                    .padding(.bottom , 15)
                }
                .navigationDestination(isPresented: $navigateToNextScreen) {
                    ActivationView(viewModel: viewModel, loginViewModel: loginViewModel, signViewModel: signViewModel ) // Pass the navigationPath
                }
            }
        .navigationBarBackButtonHidden(true) // Hide the default back button
    }
}


// Checkbox Toggle Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}
