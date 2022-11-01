//
//  SignInWithEmailView.swift
//
//

import SwiftUI

struct SignInWithEmailView: View {
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel()
    @Binding var showSheet: Bool
    @Binding var action:LoginView.Action?
	
	@State private var showAlert = false
	@State private var authError: EmailAuthError?
	
    var body: some View {
        VStack {
            TextField("Email Address",
                      text: self.$user.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $user.password)
            HStack {
                Spacer()
                Button(action: {
                    self.action = .resetPW
                    self.showSheet = true
                }) {
                    Text("Forgot Password")
                }
            }.padding(.bottom)
            VStack(spacing: 10) {
                Button(action: {
                    // Sign In Action
					
					FBAuth.authenticate(withEmail: self.user.email, password: self.user.password) { (result) in
						switch result {
						case .failure (let error):
							self.authError = error
							self.showAlert = true
						case .success( _):
							print("Signed In")
						}
					}
                }) {
                    Text("Login")
                        .padding(.vertical, 15)
                        .frame(width: 200)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .opacity(user.isLogInComplete ? 1 : 0.75)
                }.disabled(!user.isLogInComplete)
                Button(action: {
                    self.action = .signUp
                    self.showSheet = true
                }) {
                    Text("Sign Up")
                        .padding(.vertical, 15)
                        .frame(width: 200)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
			.alert(isPresented: $showAlert) {
				Alert(title: Text("Login Error"), message: Text(self.authError?.localizedDescription ?? "Unkown Error"), dismissButton: .default(Text("OK")){
					if self.authError == .incorrectPassword{
						self.user.password = ""
					}
					else
					{
						self.user.password = ""
						self.user.email = ""
					}
				})
			}
        }
        .padding(.top, 100)
        .frame(width: 300)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
}

struct SignInWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithEmailView(showSheet: .constant(false), action: .constant(.signUp))
    }
}
