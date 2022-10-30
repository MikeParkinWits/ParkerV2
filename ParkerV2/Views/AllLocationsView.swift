//
//  AllLocationsView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/30.
//

import SwiftUI

struct AllLocationsView: View {
	
	var locations: [Locations] = LocationList.nearbyFive
	
	@State var searchQuery = ""
	
	@State var filteredWords: [Locations] = []
	
	var body: some View {
		
		ScrollView(.vertical, showsIndicators: false) {
			ForEach(filteredNames, id: \.id){ location in

				NavigationLink {
					LocationDetailView(parkingLocation: location)
						.navigationBarTitle(location.name)
				} label: {
					HStack(alignment: .center){
						Image(location.imageSmall)
							.resizable()
							.scaledToFit()
							.frame(width: 70, height: 70)
							.cornerRadius(10)
							.shadow(color: Color("shadowColor").opacity(0.7), radius: 2)

						VStack(alignment: .leading, spacing: 1.0){
							Text(location.name)
								.font(.headline)
								.fontWeight(.bold)

							Text(location.location)
								.font(.subheadline)
								.fontWeight(.semibold)
								.foregroundStyle(.secondary)

							//				Label("Braamfontein", systemImage: "mappin.and.ellipse")
							//					.font(.footnote)
							//					.foregroundStyle(.secondary)


							Spacer()

							Text("0.2km Away")
								.font(.subheadline)
								.fontWeight(.regular)
								.foregroundStyle(.secondary)
						}

					}

					.frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
					.padding(10)
					.background(

						Rectangle().fill(Color("listBackgroundColour"))
							.cornerRadius(15)
							.shadow(color: Color("shadowColor").opacity(0.8), radius: 3)

					)
				}
				.padding(.horizontal)
				.padding(.top, 13)
				.buttonStyle(.plain)
			}
		}
		.searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for Parking Areas"
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
	
	var filteredNames: [Locations] {
		if searchQuery.isEmpty{
			return locations
		}else{
			return locations.filter({$0.name.localizedCaseInsensitiveContains(searchQuery) || $0.location.localizedCaseInsensitiveContains(searchQuery)})
		}
	}
}


struct AllLocationsView_Previews: PreviewProvider {
	static var previews: some View {
		AllLocationsView()
	}
}
