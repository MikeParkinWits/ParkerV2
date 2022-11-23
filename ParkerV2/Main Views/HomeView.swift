//
//  HomeView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/19.
//

// IMPORTS

import SwiftUI
import Drawer
import ParallaxSwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

// Main View - Home View

struct HomeView: View {
	
	@EnvironmentObject var userInfo: UserInfo
	
//	var locations: [ParkingArea] = ParkingAreaList.allParkingAreas
	

		private var db = Firestore.firestore()
		
//		@FirestoreQuery(
//			collectionPath: "parkingAreas",
//			predicates: []
//		) var parkingAreas: [ParkingArea1]
//
//
	
	@EnvironmentObject var viewModel: ParkingAreasViewModel
	@EnvironmentObject var viewModelObserved: ParkingHistoryViewModel
			
	let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))


	var body: some View {
		VStack() {
			NavigationView{
				ZStack{
					VStack(alignment: .leading){
						
						TitleText()
							.font(.largeTitle)
							.fontWeight(.bold)
							.multilineTextAlignment(.leading)
							.padding(.horizontal)
							.padding(.top, 40)
							.padding(.bottom, 5)
							.lineLimit(1)
							.minimumScaleFactor(0.01)
						
						HStack {
							Text("Popular Parking Areas")
								.font(.title3)
								.fontWeight(.semibold)
							
							Spacer()
							
							NavigationLink {
								
								AllLocationsView()
									.navigationBarTitle("All Parking Areas")
								
							} label: {
								Text("See all")
									.font(.subheadline)
									.foregroundColor(.secondary)
							}
							
						}
						.padding(.horizontal)
						

						
						ScrollView(.horizontal, showsIndicators: false) {
							HStack(spacing: 20) {
								ForEach(viewModel.parkingAreas.prefix(4)){ locationIndex in
									
									BigCarouselCard(for: locationIndex)
//									Text("\(locationIndex.prices)" as String)
								}
							}
							.padding(.horizontal)
						}
					
						
						Spacer()
					}

					
					//UPDATE THIS WITH DATA
					if (userInfo.user.isParked){
						if(viewModel.unwrapped){
							BottomDrawer(parkingLocation: viewModel.parkingAreas.first!)
						}
							
//						Text("\(parkingAreasViewModel.unwrapped)" as String)

					}else{
						NotParkedDrawer()
					}
				}
				.onAppear(){
					guard let uid = Auth.auth().currentUser?.uid else{
						return
					}					
							self.viewModel.fetchData()
					
					ParkingAreasViewModel().unwrapped = true
										
					FBFirestore.retrieveFBUser(uid: uid) { (result) in
						switch result{
						case .failure(let error):
							print(error.localizedDescription)
							
							//Display Error Alert
							
						case .success(let user):
							self.userInfo.user = user
						}
					}
				}
			}
		}
	}
	
	func TitleText() -> Text{
		let formatter = DateFormatter()
		formatter.dateFormat = "HH"
		let currentTime = Int(formatter.string(from: Date()))
		
		var titleText: String
		
		if (currentTime! < 12 && currentTime! >= 00)
		{
			titleText = "Good Morning \(userInfo.user.name)"
		}
		else if (currentTime! >= 12 && currentTime! < 17)
		{
			titleText = "Good Afternoon \(userInfo.user.name)"
		}
		else
		{
			titleText = "Good Evening \(userInfo.user.name)"
		}
		
		return Text(titleText)
				
	}
}

// Content Preview

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView().environmentObject(UserInfo())
	}
}

