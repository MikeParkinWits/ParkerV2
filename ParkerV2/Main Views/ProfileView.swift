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
							
							Text("\(userInfo.user.carMake)")
								.font(.footnote)
								.fontWeight(.regular)
								.foregroundColor(.secondary)
							
							Spacer()
							
								Text("100%")
									.font(.footnote)
									.fontWeight(.regular)
									.foregroundColor(.secondary)
									.frame(maxWidth: .infinity, alignment: .leading)
									.lineLimit(1)
								.minimumScaleFactor(0.8)
								.padding(0)
							
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
							TextField("\(userInfo.user.carMake)", text: $carLicensePlate)
							
							Button("Save changes") {
								
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
						
					}
					
					else if (selectedColor == "Personal")
								
					{
						Section {
							TextField("\(userInfo.user.name)", text: $firstName)
							TextField("\(userInfo.user.lastName)", text: $lastName)
							Button("Save changes") {
								
								if (user.isEmpty(_field: firstName) &&
									user.isEmpty(_field: lastName)){
									self.showAlert = true
								}else{
									Auth.auth().currentUser?.updateEmail(to: userEmail) { (error) in }
									
									guard let userID = Auth.auth().currentUser?.uid else { return }

									
									UpdateDatabase(userID: userID, newValue: firstName, variableToUpdate: "name")
									
									UpdateDatabase(userID: userID, newValue: lastName, variableToUpdate: "lastName")
									
									userInfo.user = .init(uid: userInfo.user.uid, name: firstName, email: userInfo.user.email, lastName: lastName, carMake: userInfo.user.carMake, isParked: userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
									
									self.firstName = ""
									self.lastName = ""
									self.userEmail = ""
									
									let impactMed = UIImpactFeedbackGenerator(style: .medium)
									impactMed.impactOccurred()
									
									FBFirestore.retrieveFBUser(uid: userID) { (result) in
										switch result{
										case .failure(let error):
											print(error.localizedDescription)
											
										case .success(let user):
											self.userInfo.user = user
										}
									}
									
								}
							}
						}
						.alert(isPresented: $showAlert) {
							Alert(title: Text("Update Error"), message: Text(self.authError?.localizedDescription ?? "Could not update: invalid fields"), dismissButton: .default(Text("OK")){
							})
						}
					}
				}
			header: {
				Text("Update User Details")
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
					
					Button {
						
						stopwatch.start()
						
						guard let userID = Auth.auth().currentUser?.uid else { return }
						
						if !userInfo.user.isParked{
							
							UpdateDatabaseBool(userID: userID, newValue: true, variableToUpdate: "isParked")
							
							UpdateDatabase(userID: userID, newValue: viewModel.parkingAreas.randomElement()?.parkingID ?? "", variableToUpdate: "currentParkingAreaID")
							
							
							userInfo.user = .init(uid: userInfo.user.uid, name: userInfo.user.name, email: userInfo.user.email, lastName: userInfo.user.lastName, carMake: userInfo.user.carMake, isParked: !userInfo.user.isParked, profileImageUrl: userInfo.user.profileImageUrl, currentParkingAreaID: userInfo.user.currentParkingAreaID)
							
							self.viewModel.fetchData()
							self.viewModelParkingHistory.fetchData()
							
							FBFirestore.retrieveFBUser(uid: userID) { (result) in
								switch result{
								case .failure(let error):
									print(error.localizedDescription)
									
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
				.foregroundColor(.red)
					
				}  header: {
					Text("Test Menu")
				}
			footer: {
				Text("Test the main function of the application. This emulates a guard parking your car in, and out, at a random location - adding to your history when stopped")
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

struct SheetView: View {
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		NavigationView{
			VStack(alignment: .leading, spacing: 7.5) {
				
				AboutQuestionCell(asking: "Who Created Parker?", answer: "Michael Parkin - Student Number: 189479")
				
				AboutQuestionCell(asking: "What is Parker?", answer: "Parker is an app-based platform, for mobile devices, that aims to revolutionise on-street parking in South Africa by connecting drivers directly to on-street parking guards - making on-street parking more convenient, safer, and more trustworthy for everyone.")
				
				AboutQuestionCell(asking: "Why was Parker Created?", answer: "Parker was created as a final year project for the University of Witwatersrand's Digital Arts bachelor degree")
				
				Spacer()
				
			}
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
