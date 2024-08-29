import SwiftUI

struct ActivationView: View {
    @ObservedObject var viewModel: RocketViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject  var signViewModel: SignInViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            BackgroundImage(imageName: "starss", width: .infinity, height: 0)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer().frame(width: 85)
                    
                    Text("Account Created")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                    
                    CancelButton(viewModel: viewModel, signViewModel: signViewModel, loginViewModel: loginViewModel)
                    
                }
                .padding(.horizontal)
                
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
                        .foregroundColor(.green)
                        .padding(10)
                        .background(Circle().stroke(Color.green, lineWidth: 1))
                    
                 
                }
                .padding(.vertical, 7)
                
                Spacer()
                
                VStack(spacing: 20) {
                                  Image(systemName: "checkmark.circle.fill")
                                      .resizable()
                                      .frame(width: 100, height: 100)
                                      .foregroundColor(Color.green)
                                  
                                  Text("Your account has been created.")
                                      .font(.title2)
                                      .fontWeight(.bold)
                                      .foregroundColor(.white)
                }
               
                
                Spacer()
                
           
            }
            
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
    }
}

