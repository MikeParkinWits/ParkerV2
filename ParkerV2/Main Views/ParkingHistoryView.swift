//
//  AllLocationsView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/30.
//

// IMPORTS

import SwiftUI

// ALL LOCATIONS VIEW

struct ParkingHistoryView: View {
		
	@State var searchLocations = ""
	
	@EnvironmentObject var userInfo: UserInfo
	
	@EnvironmentObject var viewModelParkingHistory: ParkingHistoryViewModel
	@EnvironmentObject var viewModel: ParkingAreasViewModel
	
	var body: some View {
		
		NavigationView{
				List(filteredLocations){ index in

					SmallListCard(isParkingCard: false, containingArea: nil, containingHistory: index)
					
				}
				.searchable(text: $searchLocations, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Parking History by Number"
				)
				.keyboardType(.numberPad)
			.onAppear(){
				self.viewModelParkingHistory.fetchData()
					
			}
			
			.navigationTitle("Parking History")

		}
		
	}
	
	// Function to search through locations
	
	var filteredLocations: [ParkingHistory] {
		if searchLocations.isEmpty
		{
			let temp = viewModelParkingHistory.parkingHistory.filter({$0.userID == userInfo.user.uid})
			let sortedUsers = temp.sorted{
				$0.id > $1.id
			}
			return sortedUsers
		}
		else{
			let temp = viewModelParkingHistory.parkingHistory.filter({($0.userID == userInfo.user.uid) && String($0.id).localizedCaseInsensitiveContains(searchLocations)})
			let sortedUsers = temp.sorted{
				$0.id > $1.id
			}
			return sortedUsers
		}
	}
}
