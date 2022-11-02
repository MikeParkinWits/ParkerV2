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

// Main View - Home View

struct HomeView: View {
	
	@EnvironmentObject var userInfo: UserInfo
	
	var locations: [ParkingArea] = ParkingAreaList.allParkingAreas
	
	var body: some View {
		VStack() {
			NavigationView{
				ZStack{
					VStack(alignment: .leading){
						
						Text("Good Afternoon")
							.font(.largeTitle)
							.fontWeight(.bold)
							.multilineTextAlignment(.leading)
							.padding(.horizontal)
							.padding(.top, 40)
							.padding(.bottom, 5)
						
						HStack {
							Text("Nearby Parking Areas")
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
								ForEach(locations.dropLast(locations.count - 5), id: \.id){ locationIndex in
									
									BigCarouselCard(for: locationIndex)
									
								}
							}
							.padding(.horizontal)
						}
						
						Spacer()
					}
					//UPDATE THIS WITH DATA
					if (userInfo.user.isParked){
						BottomDrawer(parkingLocation: ParkingAreaList.allParkingAreas.first!)
					}else{
						NotParkedDrawer()
					}
				}
				.onAppear{
					guard let uid = Auth.auth().currentUser?.uid else{
						return
					}
					
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
}

// Content Preview

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView().environmentObject(UserInfo())
	}
}
