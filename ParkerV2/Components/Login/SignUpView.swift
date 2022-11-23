//
//  SignUpView.swift
//
//

import SwiftUI
import PhotosUI
import FirebaseFirestore

// MARK: - Sign Up Function

struct SignUpView: View {
	@EnvironmentObject var userInfo: UserInfo
	@State var user: UserViewModel = UserViewModel()
	@Environment(\.presentationMode) var presentationMode
	@State private var showError = false
	@State private var errorString = ""
	
	@State private var selectedItem: PhotosPickerItem? = nil
	
	@State private var selectedImageData: Data? = nil
	
	@State private var selectedImage: UIImage?
	
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					Group {
						VStack(alignment: .leading) {
							HStack {
								
								VStack(){
									PhotosPicker(
										selection: $selectedItem,
										matching: .images,
										photoLibrary: .shared()) {
											if let selectedImageData,
											   let uiImage = UIImage(data: selectedImageData) {
												
												Image(uiImage: uiImage)
													.centerCropped()
													.frame(width: 100, height: 100)
													.cornerRadius(25)
													.shadow(color: Color("shadowColor").opacity(0.5), radius: 4)
												
												
												
											}else{
												
												BlurredBackground(style: .systemMaterial)						.frame(width: 100, height: 100)
												
													.cornerRadius(25)
													.overlay{
														VStack(spacing: 5){
															Image(systemName: "camera")
															
															Text("Upload Profile Photo")
																.font(.caption)
														}
														
														.foregroundColor(.secondary)
													}
													.shadow(color: Color("shadowColor").opacity(0.5), radius: 4)
												
												
												
												
											}
										}
										.onChange(of: selectedItem) { newItem in
											Task {
												// Retrive selected asset in the form of Data
												if let data = try? await newItem?.loadTransferable(type: Data.self) {
													selectedImageData = data
												}
											}
										}
										.padding(.trailing, 10)
								}
								VStack(alignment: .leading){
									TextField("First Name", text: self.$user.fullname).autocapitalization(.words)
										.padding(10)
										.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
										)
									
									Spacer()
										.frame(height: 15)
									
									TextField("Last Name", text: self.$user.lastName).autocapitalization(.words)
										.padding(10)
										.background(BlurredBackground(style: .systemThinMaterial).cornerRadius(10)
										)
									
									if !user.validNameText.isEmpty {
										Text(user.validNameText).font(.caption).foregroundColor(.secondary)
									}
								}
								
							}
							
							.padding(.vertical, 5)
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
					
					VStack(spacing: 20 ) {
						Button(action: {
							
							FBAuth.createUser(withEmail: self.user.email, name: self.user.fullname, password: self.user.password, lastName: self.user.lastName, carMake: self.user.carLicense, isParked: self.user.isParked, profileImageUrl: "", currentParkingAreaID: userInfo.user.currentParkingAreaID) { (result) in
								switch result{
								case .failure(let error):
									self.errorString = error.localizedDescription
									self.showError = true
								case .success(_):
									print("Account Created Sucessfully")
								}
								
							}
							if (selectedImageData != nil){
								ImageUploader.uploadImage(image: UIImage(data:selectedImageData!)!){ profileImageUrl in
									Firestore.firestore().collection("users")
										.document(userInfo.user.uid)
										.updateData(["profileImageUrl": profileImageUrl])
									
								}
							}
							
							self.presentationMode.wrappedValue.dismiss()
							
						}) {
							Text("Register")
								.padding(.vertical, 15)
								.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.06))                        .background(Color.blue)
								.cornerRadius(12.5)
								.foregroundColor(.white)
								.fontWeight(.bold)
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
