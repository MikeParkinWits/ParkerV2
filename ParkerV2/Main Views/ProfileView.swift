//
//  ProfileView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI
import FirebaseAuth
import Firebase
import Kingfisher

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
	@State private var showingTestSheet = false
	
	@EnvironmentObject var userInfo: UserInfo
	@EnvironmentObject var viewModel: ParkingAreasViewModel
	@EnvironmentObject var viewModelParkingHistory: ParkingHistoryViewModel
	
	@State var user: UserViewModel = UserViewModel()
		
//	var parkingLocation: [ParkingArea]
		
	@State private var showAlert = false
	@State private var authError: EmailAuthError?
	
	@ObservedObject var stopwatch = Stopwatch()
	
	var body: some View {
		NavigationView(){
			
			Form {
				
				Section{
					
					HStack(alignment: .top, spacing: 10.0){
						
						if (userInfo.user.profileImageUrl == ""){
							Image(systemName: "person.fill")
								.resizable()
								.scaledToFit()
								.padding(10)
								.frame(width: 80, height: 80)
								.foregroundColor(.secondary)
							//							.background(BlurredBackground(style: .systemThinMaterial)
							//								.cornerRadius(10)
							//								)
								.background(Rectangle().fill(Color("listBackgroundColour"))
									.frame(width: 80, height: 80)
									.cornerRadius(15)
									.shadow(color: Color("shadowColor").opacity(0.3), radius: 4)
								)
						}
						else
						{
							KFImage(URL(string: userInfo.user.profileImageUrl))
								.centerCropped()
								.frame(width: 80, height: 80)
								.cornerRadius(15)
								.shadow(color: Color("shadowColor").opacity(1), radius: 4)
								
						}

						
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
							
							Spacer()
							
							Text("Rating: 100%")
								.font(.footnote)
								.fontWeight(.regular)
								.foregroundColor(.secondary)
								.frame(maxWidth: .infinity, alignment: .leading)
								.lineLimit(1)
								.minimumScaleFactor(0.8)
						}
						.frame(height: 75)
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
							TextField("\(userInfo.user.carMake)", text: $carLicensePlate)
							
							Button("Save changes") {
								// activate theme!
								
								if (user.isEmpty(_field: carLicensePlate)){
									self.showAlert = true
								}else{
									
									guard let userID = Auth.auth().currentUser?.uid else { return }
									
									UpdateDatabase(userID: userID, newValue: carLicensePlate, variableToUpdate: "carMake")
									
									userInfo.user = .init(uid: userInfo.user.uid, name: userInfo.user.name, email: userInfo.user.email, lastName: userInfo.user.lastName, carMake: carLicensePlate.uppercased(), isParked: userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
									
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
							TextField("\(userInfo.user.name)", text: $firstName)
							TextField("\(userInfo.user.lastName)", text: $lastName)
							TextField("\(userInfo.user.email)", text: $userEmail)
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
									
									userInfo.user = .init(uid: userInfo.user.uid, name: firstName, email: userEmail, lastName: lastName, carMake: userInfo.user.carMake, isParked: userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
									
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
				Text("Learn more about the app and project")
			}
				
				
				Section {

//					Button {
//						showingTestSheet.toggle()
//					} label: {
//						Label("Test Menu", systemImage: "info.circle")
//					}
//					.sheet(isPresented: $showingTestSheet) {
//						TestSheetView()
//					}

						Button {
							
							stopwatch.start()
							
							guard let userID = Auth.auth().currentUser?.uid else { return }

							if !userInfo.user.isParked{

								UpdateDatabaseBool(userID: userID, newValue: true, variableToUpdate: "isParked")

//								print(viewModel.parkingAreas)

								UpdateDatabase(userID: userID, newValue: viewModel.parkingAreas.randomElement()?.parkingID ?? "", variableToUpdate: "currentParkingAreaID")


								userInfo.user = .init(uid: userInfo.user.uid, name: userInfo.user.name, email: userInfo.user.email, lastName: userInfo.user.lastName, carMake: userInfo.user.carMake, isParked: !userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
								
								self.viewModel.fetchData()
								self.viewModelParkingHistory.fetchData()
								
								FBFirestore.retrieveFBUser(uid: userID) { (result) in
									switch result{
									case .failure(let error):
										print(error.localizedDescription)
										
										//Display Error Alert
										
									case .success(let user):
										self.userInfo.user = user
									}
								}

							}else{
								let db = Firestore.firestore()
								let idValue = viewModelParkingHistory.parkingHistory.count
																
								let mytime = Date()
								let format = DateFormatter()
								format.dateFormat = "dd-MM-yyyy"
								
//								let parkingLocation = viewModel.parkingAreas.first(where: {$0.parkingID == userInfo.user.currentParkingAreaID})
//								var jj = 0
//
//								print(parkingLocation)
//
//								for currentRow in parkingLocation!.prices{
//									if (Int(stopwatch.elapsedTime) >= currentRow.timeLow && Int(stopwatch.elapsedTime) < currentRow.timeHigh) {
//										jj = currentRow.price
//									}
//								}

								db.collection("history").document(UUID().uuidString).setData([
									"id": idValue,
									"userID": "\(userID)",
									
									"date": format.string(from: mytime),
									"price": 0,
									
									"timeParked": Int(stopwatch.elapsedTime/60),
									
									"parkingAreaId": userInfo.user.currentParkingAreaID,
																		
									"guardInfo": [
										"1": [
											"image": "test-profile-image",
											"name": "John Smith",
											"rating": 98
										]
									]
									
									
									
								]) { err in
									if let err = err {
										print("Error writing document: \(err)")
									} else {
										print("Document successfully written!")
									}
								}
								
								stopwatch.stop()
								
								
								UpdateDatabaseBool(userID: userID, newValue: false, variableToUpdate: "isParked")

//								print(viewModel.parkingAreas)

								UpdateDatabase(userID: userID, newValue: "", variableToUpdate: "currentParkingAreaID")


								userInfo.user = .init(uid: userInfo.user.uid, name: userInfo.user.name, email: userInfo.user.email, lastName: userInfo.user.lastName, carMake: userInfo.user.carMake, isParked: !userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
								
							}
//								guard let userID = Auth.auth().currentUser?.uid else { return }
//
//								UpdateDatabaseBool(userID: userID, newValue: !userInfo.user.isParked, variableToUpdate: "isParked")
//
////								print(viewModel.parkingAreas)
//
//								UpdateDatabase(userID: userID, newValue: "", variableToUpdate: "currentParkingAreaID")
//
//								userInfo.user = .init(uid: userInfo.user.uid, name: userInfo.user.name, email: userInfo.user.email, lastName: userInfo.user.lastName, carMake: userInfo.user.carMake, isParked: !userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
//
////								let db = Firestore.firestore()
////								let idValue = viewModelParkingHistory.parkingHistory.count
//
////								let filtered = viewModel.parkingAreas.first(where: {$0.parkingID == userInfo.user.currentParkingAreaID})
////
////								print(filtered)
//
////								print(viewModel.parkingAreas.first(where: {$0.parkingID == userInfo.user.currentParkingAreaID})!.name)
////								print(filteredLocations[0].imageSmall)
////
//
//
////								db.collection("history").document(UUID().uuidString).setData([
////									"id": idValue,
////									"userID": "\(userID)",
////
////									"image": filtered.image,
////									"imageSmall": filtered.imageSmall,
////									"name": filtered.name,
////									"location": filtered.location,
////									"locationLat": filtered.locationLat,
////									"locationLong": filtered.locationLong,
////									"date": "",
////									"price": 0,
////
////									"timeParked": 43,
////
////									"parkingAreaID": filtered.parkingID,
////
////									"parkingArea": filtered.parkingID,
////
////									"guardInfo": [
////										"1": [
////											"image": "test-profile-picture",
////											"name": "John Smith",
////											"rating": 98
////											]
////										]
////
////
////
////								]) { err in
////									if let err = err {
////										print("Error writing document: \(err)")
////									} else {
////										print("Document successfully written!")
////									}
////								}
//
//							}

						}
						 label: {
							 if !userInfo.user.isParked{
								 Label("Start Parking Session Test", systemImage: "play.circle")
							 }
							 else
							 {
								 Label("Stop Parking Session Test", systemImage: "stop.circle")
							 }
						}
//						 .onAppear(){
//							 self.parkingAreasViewModel.fetchData()
////							 self.viewModelParkingHistory.fetchData()
//					 }
					




				}  header: {
					Text("Test Menu")
				}
			footer: {
				Text("Test the main function of the app")
			}
			}
			.onAppear(){
				self.viewModel.fetchData()
				self.viewModelParkingHistory.fetchData()
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

//struct ProfileView_Previews: PreviewProvider {
//	static var previews: some View {
//		ProfileView().environmentObject(UserInfo())
//	}
//}

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

//struct TestSheetView: View {
//	@Environment(\.dismiss) var dismiss
//
//	@EnvironmentObject var userInfo: UserInfo
//
//	@ObservedObject private var parkingAreasViewModel = ParkingAreasViewModel()
////
////	@StateObject var viewModelParkingHistory = ParkingHistoryViewModel()
////
//////		var parkingLocation: [ParkingArea]
//
//	var body: some View {
//		NavigationView{
//			VStack(alignment: .leading, spacing: 7.5) {
//
//				Form {
//
//					Section {
//						Button {
//
//							if !userInfo.user.isParked{
//								guard let userID = Auth.auth().currentUser?.uid else { return }
//
//								UpdateDatabaseBool(userID: userID, newValue: !userInfo.user.isParked, variableToUpdate: "isParked")
//
////								print(viewModel.parkingAreas)
//
//								UpdateDatabase(userID: userID, newValue: parkingAreasViewModel.parkingAreas.randomElement()?.parkingID ?? "", variableToUpdate: "currentParkingAreaID")
//
//
//								userInfo.user = .init(uid: userInfo.user.uid, name: userInfo.user.name, email: userInfo.user.email, lastName: userInfo.user.lastName, carMake: userInfo.user.carMake, isParked: !userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
//
//							}else{
//								guard let userID = Auth.auth().currentUser?.uid else { return }
//
//								UpdateDatabaseBool(userID: userID, newValue: !userInfo.user.isParked, variableToUpdate: "isParked")
//
////								print(viewModel.parkingAreas)
//
//								UpdateDatabase(userID: userID, newValue: "", variableToUpdate: "currentParkingAreaID")
//
//								userInfo.user = .init(uid: userInfo.user.uid, name: userInfo.user.name, email: userInfo.user.email, lastName: userInfo.user.lastName, carMake: userInfo.user.carMake, isParked: !userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
//
////								let db = Firestore.firestore()
////								let idValue = viewModelParkingHistory.parkingHistory.count
//
////								let filtered = viewModel.parkingAreas.first(where: {$0.parkingID == userInfo.user.currentParkingAreaID})
////
////								print(filtered)
//
////								print(viewModel.parkingAreas.first(where: {$0.parkingID == userInfo.user.currentParkingAreaID})!.name)
////								print(filteredLocations[0].imageSmall)
////
//
//
////								db.collection("history").document(UUID().uuidString).setData([
////									"id": idValue,
////									"userID": "\(userID)",
////
////									"image": filtered.image,
////									"imageSmall": filtered.imageSmall,
////									"name": filtered.name,
////									"location": filtered.location,
////									"locationLat": filtered.locationLat,
////									"locationLong": filtered.locationLong,
////									"date": "",
////									"price": 0,
////
////									"timeParked": 43,
////
////									"parkingAreaID": filtered.parkingID,
////
////									"parkingArea": filtered.parkingID,
////
////									"guardInfo": [
////										"1": [
////											"image": "test-profile-picture",
////											"name": "John Smith",
////											"rating": 98
////											]
////										]
////
////
////
////								]) { err in
////									if let err = err {
////										print("Error writing document: \(err)")
////									} else {
////										print("Document successfully written!")
////									}
////								}
//
//							}
//
//
//
//							dismiss()
//
//						}
//						 label: {
//							 if !userInfo.user.isParked{
//								 Label("Start Parking Session Test", systemImage: "play.circle")
//							 }
//							 else
//							 {
//								 Label("Stop Parking Session Test", systemImage: "stop.circle")
//							 }
//						}
//						 .onAppear(){
//							 self.parkingAreasViewModel.fetchData()
////							 self.viewModelParkingHistory.fetchData()
//					 }
//					}
//				header: {
//					Text("Parking Session")
//				}
//			footer: {
//				Text("Emulate a guard parking your car in and out at different locations. All emulated parking sessions are then added to your profiles parking history")
//			}
//				}
//
//				Spacer()
//
//			}
//			//			.padding(.top, -25)
//			.navigationBarTitle("Test Menu", displayMode: .inline)
//			.navigationBarItems(trailing:
//									Button {
//				dismiss()
//			} label: {
//				Image(systemName: "xmark.circle.fill")
//					.resizable()
//					.scaledToFit()
//					.frame(width: 25, height: 25)
//			}
//				.buttonStyle(.plain)
//				.foregroundColor(.secondary)
//			)
//		}
//
//	}
//
////	var filteredLocations: [ParkingArea] {
//////		viewModel.fetchData()
////		return parkingLocation.filter({$0.parkingID == userInfo.user.currentParkingAreaID})
////	}
//}


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

func UpdateDatabaseBool(userID: String, newValue: Bool, variableToUpdate: String) {
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
