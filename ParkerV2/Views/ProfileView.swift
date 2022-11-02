//
//  ProfileView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ProfileView: View {
	
	@State private var firstName = ""
	@State private var lastName = ""
	@State private var userEmail = ""
	
	@State private var carMake = ""
	@State private var carLicensePlate = ""
	
	@State private var enableLogging = false
	@State private var selectedColor = "Personal"
	@State private var colors = ["Personal", "Vehicle"]
	
	@State private var showingSheet = false
	
	@EnvironmentObject var userInfo: UserInfo
	
	@State var user: UserViewModel = UserViewModel()
	
	@State private var showAlert = false
	@State private var authError: EmailAuthError?
	
	var body: some View {
		NavigationView(){
			//			Form{
			//				Section{
			//					HStack(alignment: .top, spacing: 10.0){
			//						Image("test-image-two-square")
			//							.resizable()
			//							.scaledToFit()
			//							.cornerRadius(10)
			//							.frame(width: 80, height: 80)
			//
			//						VStack(alignment: .leading, spacing: 2.0) {
			//							Text("Jake Sky")
			//								.font(.title3)
			//								.fontWeight(.semibold)
			//
			//							Text("Ford Fiesta")
			//								.font(.subheadline)
			//								.fontWeight(.regular)
			//
			//							Text("BB11BB GP")
			//								.font(.footnote)
			//								.fontWeight(.regular)
			//								.foregroundColor(.secondary)
			//						}
			//					}
			//					.padding(.vertical, 2)
			//				}
			//
			//
			//
			//
			////				List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
			////					NavigationLink {
			////						Section {
			////							TextField(carName != "" ? carName : "Car Make", text: $carName)
			////						} header: {
			////							Text("Car Details")
			////					}
			////					} label: {
			////						Text("Hellos")
			////
			////					}
			////
			////				}
			//
			////				Section {
			////					TextField(firstName != "" ? firstName : "First Name", text: $firstName)
			////					TextField(lastName != "" ? lastName : "Last Name", text: $lastName)
			////					TextField(userEmail != "" ? userEmail : "Email", text: $userEmail)
			////				} header: {
			////					Text("User Information")
			////			}
			////
			////				Section {
			////					TextField(carMake != "" ? carMake : "Car Make", text: $carMake)
			////					TextField(carLicensePlate != "" ? carLicensePlate : "License Plate Number", text: $carLicensePlate)
			////				} header: {
			////					Text("Car Details")
			////			}
			////
			////				Section {
			////					TextField(carMake != "" ? carMake : "Car Make", text: $carMake)
			////					TextField(carLicensePlate != "" ? carLicensePlate : "License Plate Number", text: $carLicensePlate)
			////				} header: {
			////					Text("Car Details")
			////			}
			//
			//
			//			}
			
			Form {
				
				Section{
					HStack(alignment: .top, spacing: 10.0){
						Image(systemName: "person.crop.circle")
							.resizable()
							.scaledToFit()
							.padding(5)
							.cornerRadius(10)
							.frame(width: 80, height: 80)
							.foregroundColor(.secondary)
						//							.background(BlurredBackground(style: .systemThinMaterial)
						//								.cornerRadius(10)
						//								)
							.background(Circle().fill(.white)
								.shadow(color: Color("shadowColor").opacity(0.5), radius: 4)
							)
						
						VStack(alignment: .leading, spacing: 2.0) {
							Text("\(userInfo.user.name) \(userInfo.user.lastName)")
								.font(.title3)
								.fontWeight(.semibold)
							
							//							Text("Ford Fiesta")
							//								.font(.subheadline)
							//								.fontWeight(.regular)
							
							Text("\(userInfo.user.carMake)")
								.font(.footnote)
								.fontWeight(.regular)
								.foregroundColor(.secondary)
						}
					}
					.padding(.vertical, 2)
				}
				Section{
					Picker("Select a detail", selection: $selectedColor) {
						ForEach(colors, id: \.self) {
							Text($0)
						}
						
					}
					.pickerStyle(.segmented)
					
					if (selectedColor == "Vehicle") {
						Section {
							//							TextField(carMake != "" ? carMake : "Car Make", text: $carMake)
							TextField(carLicensePlate != "" ? carLicensePlate : "License Plate Number", text: $carLicensePlate)
							
							Button("Save changes") {
								// activate theme!
								
								if (user.isEmpty(_field: carLicensePlate)){
									self.showAlert = true
								}else{
									
									guard let userID = Auth.auth().currentUser?.uid else { return }
									
									UpdateDatabase(userID: userID, newValue: carLicensePlate, variableToUpdate: "carMake")
									
									userInfo.user = .init(uid: userInfo.user.uid, name: userInfo.user.name, email: userInfo.user.email, lastName: userInfo.user.lastName, carMake: carLicensePlate.uppercased())
									
									self.carLicensePlate = ""
									
									let impactMed = UIImpactFeedbackGenerator(style: .medium)
									impactMed.impactOccurred()
									
								}
							}
							
						}
						.alert(isPresented: $showAlert) {
							Alert(title: Text("Update Error"), message: Text(self.authError?.localizedDescription ?? "Could not update: invalid fields"), dismissButton: .default(Text("OK")){
							})
						}
						
						//					header: {
						//							Text("Car Details")
						//						}
						
					}
					
					else if (selectedColor == "Personal")
								
					{
						Section {
							TextField("First Name", text: $firstName)
							TextField(lastName != "" ? lastName : "Last Name", text: $lastName)
							TextField(userEmail != "" ? userEmail : "Email", text: $userEmail)
							Button("Save changes") {
								// activate theme!
								
								if (!user.isEmailValid(_email: userEmail) && user.isEmpty(_field: firstName) &&
									user.isEmpty(_field: lastName)){
									self.showAlert = true
								}else{
									Auth.auth().currentUser?.updateEmail(to: userEmail) { (error) in
										// ...
									}
									
									guard let userID = Auth.auth().currentUser?.uid else { return }
									
									UpdateDatabase(userID: userID, newValue: firstName, variableToUpdate: "firstName")
									
									UpdateDatabase(userID: userID, newValue: lastName, variableToUpdate: "lastName")
									
									userInfo.user = .init(uid: userInfo.user.uid, name: firstName, email: userEmail, lastName: lastName, carMake: userInfo.user.carMake)
									
									self.firstName = ""
									self.lastName = ""
									self.userEmail = ""
									
									let impactMed = UIImpactFeedbackGenerator(style: .medium)
									impactMed.impactOccurred()
									
								}
								
								
								
								
							}
						}
						.alert(isPresented: $showAlert) {
							Alert(title: Text("Update Error"), message: Text(self.authError?.localizedDescription ?? "Could not update: invalid fields"), dismissButton: .default(Text("OK")){
							})
						}
						
						//						header: {
						//							Text("User Information")
						//						}
					}
					
					
				}
			header: {
				Text("User Details")
			}
			footer: {
				Text("Update all of your \(selectedColor.lowercased()) information")
			}
				
				Section {
					Button {
						showingSheet.toggle()
					} label: {
						Label("About", systemImage: "info.circle")
					}
					.sheet(isPresented: $showingSheet) {
						SheetView()
					}
					
				}  header: {
					Text("About")
				}
			footer: {
				Text("Learn more about the app and projects")
			}
			}
			
			.navigationTitle("Profile")
			.toolbar{
				ToolbarItem(placement: .navigationBarTrailing){
					Button {
						//Logout Action Here
						
						//						self.userInfo.isUserAuthenticated = .signedOut
						
						FBAuth.logout{(result) in
							print("Logged Out")
						}
					} label: {
						Text("Sign Out")
					}
					
				}
			}
		}
	}
}

struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileView().environmentObject(UserInfo())
	}
}

struct SheetView: View {
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		NavigationView{
			VStack(alignment: .leading, spacing: 7.5) {
				
				AboutQuestionCell(asking: "Who Created Parker?", answer: "Michael Parkin - Student Number: 189479")
				
				AboutQuestionCell(asking: "What is Parker?", answer: "Parker is an app-based platform, for mobile devices, that aims to revolutionise on-street parking in South Africa by connecting drivers directly to on-street parking guards - making on-street parking more convenient, safer, and more trustworthy for everyone.")
				
				AboutQuestionCell(asking: "Why was Parker Created?", answer: "Parker was created as a final year project for the University of Witwwatersrand's Digital Arts bachelor degree")
				
				//				AboutQuestionCell(asking: "How Does Parker Work?", answer: "Parker was created for ")
				
				Spacer()
				
			}
			//			.padding(.top, -25)
			.navigationBarTitle("About", displayMode: .inline)
			.navigationBarItems(trailing:
									Button {
				dismiss()
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

struct AboutQuestionCell: View {
	
	var question: String
	var answer: String
	
	init(asking question: String, answer: String) {
		self.question = question
		self.answer = answer
	}
	
	var body: some View {
		Group{
			Text(question)
				.font(.title3)
				.fontWeight(.semibold)
			
			Text(answer)
				.padding(.bottom, 15)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.horizontal)
	}
	
}

func UpdateDatabase(userID: String, newValue: String, variableToUpdate: String) {
	let db = Firestore.firestore()
	
	let docRef = db.collection("users").document(userID)
	
	docRef.updateData([variableToUpdate: newValue]) { error in
		if let error = error {
			print("Error updating document: \(error)")
		} else {
			print("Document successfully updated!")
		}
	}
}
