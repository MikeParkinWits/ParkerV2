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
	
	var parkingHistory: [ParkingHistory] = ParkingHistoryList.AllParkingHistory
	
	@State var searchLocations = ""
	
	var body: some View {
		
		NavigationView{
			ScrollView(.vertical, showsIndicators: false) {
				ForEach(filteredLocations, id: \.id){ index in
					
					SmallListCard(isParkingCard: false, containingArea: nil, containingHistory: index)
					
				}
				.searchable(text: $searchLocations, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Parking History by Name or Area"
							//					, suggestions: {
							//			// 1
							//			Button("Pizza") {
							//				searchQuery = "pizza"
							//			}
							//			// 2
							//			Text("Chicken Salad")
							//				.searchCompletion("Chicken Salad")
							//		}
				)
			}
			.navigationTitle("Parking History")

		}
		
		
		//			List(filteredNames, id: \.id){ location in
		//
		//				NavigationLink {
		//					LocationDetailView(parkingLocation: location)
		//						.navigationBarTitle(location.name)
		//				} label: {
		//					HStack(alignment: .center){
		//						Image(location.imageSmall)
		//							.resizable()
		//							.scaledToFit()
		//							.frame(width: 70, height: 70)
		//							.cornerRadius(10)
		//							.shadow(color: Color("shadowColor").opacity(0.7), radius: 2)
		//
		//						VStack(alignment: .leading, spacing: 1.0){
		//							Text(location.name)
		//								.font(.headline)
		//								.fontWeight(.bold)
		//
		//							Text(location.location)
		//								.font(.subheadline)
		//								.fontWeight(.semibold)
		//								.foregroundStyle(.secondary)
		//
		//							//				Label("Braamfontein", systemImage: "mappin.and.ellipse")
		//							//					.font(.footnote)
		//							//					.foregroundStyle(.secondary)
		//
		//
		//							Spacer()
		//
		//							Text("0.2km Away")
		//								.font(.subheadline)
		//								.fontWeight(.regular)
		//								.foregroundStyle(.secondary)
		//						}
		//
		//					}
		//
		//					.frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
		//					.padding(10)
		//
		//				}
		//				.padding(.horizontal, -10)
		//				.padding(.vertical, 0)
		//				.buttonStyle(.plain)
		//			}
		//			.searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for Parking Areas"
		//						//					, suggestions: {
		//						//			// 1
		//						//			Button("Pizza") {
		//						//				searchQuery = "pizza"
		//						//			}
		//						//			// 2
		//						//			Text("Chicken Salad")
		//						//				.searchCompletion("Chicken Salad")
		//						//		}
		//			)
		//			.padding(.top, -30)
		
	}
	
	// Function to search through locations
	
	var filteredLocations: [ParkingHistory] {
		if searchLocations.isEmpty
		{
			return parkingHistory
		}
		else
		{
			return parkingHistory.filter({$0.name.localizedCaseInsensitiveContains(searchLocations) || $0.location.localizedCaseInsensitiveContains(searchLocations)})
		}
	}
}

// Content Preview

struct ParkingHistoryView_Previews: PreviewProvider {
	static var previews: some View {
		ParkingHistoryView()
	}
}
