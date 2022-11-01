//
//  ForgotPasswordView.swift
//
//

import SwiftUI

struct ForgotPasswordView: View {
	@State var user: UserViewModel = UserViewModel()
	@Environment(\.presentationMode) var presentationMode
	
	@State private var showAlert = false
	@State private var errString: String?
	
	var body: some View {
		NavigationView {
			VStack {
				TextField("Enter email address", text: $user.email)
					.autocapitalization(.none)
					.keyboardType(.emailAddress)
					.padding(10)
					.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
					)
					.padding(.vertical, 5)
				
				Button(action: {
					// Reset Password action
					
					FBAuth.resetPassword(email: self.user.email) { (result) in
						switch (result) {
						case .failure(let error):
							self.errString = error.localizedDescription
						case .success( _):
							break
						}
						self.showAlert = true
					}
				}) {
					Text("Request Password Reset")
					
						.padding(.vertical, 15)
						.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.06))                        .background(Color.blue)
						.cornerRadius(12.5)
						.foregroundColor(.white)
						.fontWeight(.bold)
					
					//						.frame(width: 200)
					//						.padding(.vertical, 15)
					//						.background(Color.green)
					//						.cornerRadius(8)
					//						.foregroundColor(.white)
						.opacity(user.isEmailValid(_email: user.email) ? 1 : 0.75)
				}
				.disabled(!user.isEmailValid(_email: user.email))
				.padding(.top, 7.5)
				
				Spacer()
			}
			.padding(.horizontal)
			.padding(.top, 7.5)
			//				.frame(width: 300)
			//				.textFieldStyle(RoundedBorderTextFieldStyle())
			.navigationBarTitle("Reset Password", displayMode: .inline)
			.navigationBarItems(trailing:
									
									Button {
				self.presentationMode.wrappedValue.dismiss()
			} label: {
				Image(systemName: "xmark.circle.fill")
					.resizable()
					.scaledToFit()
					.frame(width: 25, height: 25)
			}
				.buttonStyle(.plain)
				.foregroundColor(.secondary)
								
			)
			.alert(isPresented: $showAlert){
				Alert(title: Text("Password Reset"),
					  message: Text(self.errString ?? "Success. A reset email has been sent"), dismissButton: .default(Text("OK")){
					self.presentationMode.wrappedValue.dismiss()
				})
			}
		}
	}
	
	
	struct ForgotPasswordView_Previews: PreviewProvider {
		static var previews: some View {
			ForgotPasswordView()
		}
	}
}
