//
//  SignInWithEmailView.swift
//
//

import SwiftUI
import PhotosUI

// MARK: - Sign In Function

struct SignInWithEmailView: View {
	@EnvironmentObject var userInfo: UserInfo
	@State var user: UserViewModel = UserViewModel()
	@Binding var showSheet: Bool
	@Binding var action:LoginView.Action?
	
	@State private var showAlert = false
	@State private var authError: EmailAuthError?
	
	var body: some View {
		
		VStack {
			Image("ParkerLogoLogin")
				.resizable()
				.scaledToFit()
				.frame(width: 125, height: 125)
				.padding()
			
			TextField("Email Address",
					  text: self.$user.email)
			.autocapitalization(.none)
			.keyboardType(.emailAddress)
			.padding(10)
			.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
			)
			.padding(.vertical, 5)
			
			SecureField("Password", text: $user.password)
				.padding(10)
				.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
				)
				.padding(.vertical, 5)
			
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
						.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.06))                        .background(Color.blue)
						.cornerRadius(12.5)
						.foregroundColor(.white)
						.fontWeight(.bold)
						.opacity(user.isLogInComplete ? 1 : 0.75)
				}
				.disabled(!user.isLogInComplete)
				
				HStack{
					Text("Don't have an account?")
					Button(action: {
						self.action = .signUp
						self.showSheet = true
					}) {
						Text("Sign Up")
					}
				}
				.font(.subheadline)
				.fontWeight(.regular)
				.padding(.top, 8)
				
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
		.padding(.horizontal)
		
	}
}

struct SignInWithEmailView_Previews: PreviewProvider {
	static var previews: some View {
		SignInWithEmailView(showSheet: .constant(false), action: .constant(.signUp))
	}
}
