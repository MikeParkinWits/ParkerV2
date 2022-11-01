//
//  ProfileView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI

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
						Image("test-image-two-square")
							.resizable()
							.scaledToFit()
							.cornerRadius(10)
							.frame(width: 80, height: 80)
						
						VStack(alignment: .leading, spacing: 2.0) {
							Text("Jake Sky")
								.font(.title3)
								.fontWeight(.semibold)
							
							Text("Ford Fiesta")
								.font(.subheadline)
								.fontWeight(.regular)
							
							Text("BB11BB GP")
								.font(.footnote)
								.fontWeight(.regular)
								.foregroundColor(.secondary)
						}
					}
					.padding(.vertical, 2)
				}
				Section{
					Picker("Select a color", selection: $selectedColor) {
						ForEach(colors, id: \.self) {
							Text($0)
						}
						
					}
					.pickerStyle(.segmented)
					
					if (selectedColor == "Vehicle") {
						Section {
							TextField(carMake != "" ? carMake : "Car Make", text: $carMake)
							TextField(carLicensePlate != "" ? carLicensePlate : "License Plate Number", text: $carLicensePlate)
							
							Button("Save changes") {
								// activate theme!
							}
							
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
							}
						}
//						header: {
//							Text("User Information")
//						}
					}

					
				}
			header: {
				Text("Information")
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
		ProfileView()
	}
}

struct SheetView: View {
	@Environment(\.dismiss) var dismiss

	var body: some View {
		VStack(alignment: .leading, spacing: 5.0) {
			HStack {
					Text("About")
						.font(.largeTitle)
					.fontWeight(.bold)
				
				Spacer()
				
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
				
			}
			.padding(.vertical)
			
			AboutQuestionCell(asking: "Who Created parker?", answer: "Parker was created for ")
			
			AboutQuestionCell(asking: "Why was Parker Created?", answer: "Parker was created for ")
			
			AboutQuestionCell(asking: "How Does Parker Work?", answer: "Parker was created for ")

			

			
			Spacer()

		}
		.padding(.horizontal)
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
				.font(.title2)
				.fontWeight(.semibold)
			
			Text(answer)
		}
	}
}
