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

// Main View - Home View

struct HomeView: View {
	
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
					
					BottomDrawer()
				}
			}
		}
	}
}

// Content Preview

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
