//
//  SignUpView.swift
//
//

import SwiftUI

struct SignUpView: View {
	@EnvironmentObject var userInfo: UserInfo
	@State var user: UserViewModel = UserViewModel()
	@Environment(\.presentationMode) var presentationMode
	@State private var showError = false
	@State private var errorString = ""
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					Group {
						VStack(alignment: .leading) {
							HStack {
								TextField("First Name", text: self.$user.fullname).autocapitalization(.words)
									.padding(10)
									.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
									)
								
								Spacer()
								
								TextField("First Name", text: self.$user.lastName).autocapitalization(.words)
									.padding(10)
									.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
									)
							}
							
							.padding(.vertical, 5)
							
							if !user.validNameText.isEmpty {
								Text(user.validNameText).font(.caption).foregroundColor(.secondary)
							}
						}
						
						VStack(alignment: .leading) {
							HStack {
								
								TextField("Car License", text: self.$user.carLicense).autocapitalization(.words)
									.padding(10)
									.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
									)
								
								Spacer()
								
	//							TextField("First Name", text: self.$user.lastName).autocapitalization(.words)
	//								.padding(10)
	//								.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
	//								)
							}
							
							.padding(.vertical, 5)
							
							if !user.validCarMake.isEmpty {
								Text(user.validCarMake).font(.caption).foregroundColor(.secondary)
							}
						}
						
						VStack(alignment: .leading) {
							TextField("Email Address", text: self.$user.email).autocapitalization(.none).keyboardType(.emailAddress)
								.padding(10)
								.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
								)
								.padding(.vertical, 5)
							
							if !user.validEmailAddressText.isEmpty {
								Text(user.validEmailAddressText).font(.caption).foregroundColor(.secondary)
							}
						}
						VStack(alignment: .leading) {
							SecureField("Password", text: self.$user.password)
								.padding(10)
								.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
								)
								.padding(.vertical, 5)
							
							if !user.validPasswordText.isEmpty {
								Text(user.validPasswordText).font(.caption).foregroundColor(.secondary)
							}
						}
						VStack(alignment: .leading) {
							SecureField("Confirm Password", text: self.$user.confirmPassword)
								.padding(10)
								.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
								)
								.padding(.vertical, 5)
							
							if !user.passwordsMatch(_confirmPW: user.confirmPassword) {
								Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.secondary)
							}
						}
					}
					.padding(.horizontal)
					//				.frame(width: 300)
					//					.textFieldStyle(RoundedBorderTextFieldStyle())
					
					VStack(spacing: 20 ) {
						Button(action: {
							FBAuth.createUser(withEmail: self.user.email, name: self.user.fullname, password: self.user.password, lastName: self.user.lastName, carMake: self.user.carLicense) { (result) in
								switch result{
								case .failure(let error):
									self.errorString = error.localizedDescription
									self.showError = true
								case .success(_):
									print("Account Created Sucessfully")
								}
								
							}
							
						}) {
							Text("Register")
								.padding(.vertical, 15)
								.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.06))                        .background(Color.blue)
								.cornerRadius(12.5)
								.foregroundColor(.white)
								.fontWeight(.bold)
							
							//							.frame(width: 200)
							//							.padding(.vertical, 15)
							//							.background(Color.green)
							//							.cornerRadius(8)
							//							.foregroundColor(.white)
								.opacity(user.isSignInComplete ? 1 : 0.75)
						}
						
						.disabled(!user.isSignInComplete)
						Spacer()
					}.padding()
				}.padding(.top)
					.alert(isPresented: $showError){
						Alert(title: Text("Error creating account"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
					}
					.navigationBarTitle("Sign Up", displayMode: .inline)
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
			}
		}
	}
}

struct SignUpView_Previews: PreviewProvider {
	static var previews: some View {
		SignUpView()
	}
}
