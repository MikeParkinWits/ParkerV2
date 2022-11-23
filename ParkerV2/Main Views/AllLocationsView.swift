//
//  AllLocationsView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/30.
//

// IMPORTS

import SwiftUI

// ALL LOCATIONS VIEW

struct AllLocationsView: View {
	
	@State var searchLocations = ""
	
	@EnvironmentObject var viewModel: ParkingAreasViewModel
	
	var body: some View {
		
		List(filteredLocations, id: \.id){ index in
			
			SmallListCard(isParkingCard: true, containingArea: index, containingHistory: nil)
			
		}
		.padding(.top, -30)
		.searchable(text: $searchLocations, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Parking Areas by Name or Area"
		)
		
	}
	
	// Function to search through locations
	
	var filteredLocations: [ParkingArea] {
		if searchLocations.isEmpty
		{
			return viewModel.parkingAreas
		}
		else
		{
			return viewModel.parkingAreas.filter({$0.name.localizedCaseInsensitiveContains(searchLocations) || $0.location.localizedCaseInsensitiveContains(searchLocations)})
		}
	}
	
}

// Content Preview

struct AllLocationsView_Previews: PreviewProvider {
	static var previews: some View {
		AllLocationsView()
	}
}
