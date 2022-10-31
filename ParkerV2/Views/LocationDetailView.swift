//
//  LocationDetailView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/28.
//

// IMPORTS

import SwiftUI
import MapKit

// LOCATION DETAIL VIEW

struct LocationDetailView: View {
	
	var parkingLocation: ParkingArea
	
	var body: some View {
		
		NavigationView{
			VStack(spacing: 15.0) {
				
				LocationMap(isParkingArea: true, at: parkingLocation, at: nil)
				
				VStack(alignment: .leading, spacing: 7){

					Text("Prices")
						.font(.title2)
						.fontWeight(.bold)
						.padding(.bottom, 5)
						
						ForEach(0..<parkingLocation.prices.count, id: \.self){currentRow in
							
							DisplaySinglePriceRow(at: parkingLocation, on: currentRow)
							
						}
				}
				
				Spacer()
				
			}
			.padding(.horizontal)
			.padding(.top, 15)
			
		}
	}
}

// PRICE CODE

// Single Price Row Cell
struct DisplaySinglePriceRow: View{
	
	var i: Int
	
	var parkingLocation: ParkingArea
	
	init(at parkingLocation: ParkingArea, on i: Int) {
		self.i = i
		self.parkingLocation = parkingLocation
	}
	
	var body: some View{
		HStack(spacing: 4){
			Text(self.parkingLocation.prices[i].time)
				.font(.body)
				.fontWeight(.medium)
			Text("min")
				.font(.body)
				.fontWeight(.medium)
				.foregroundColor(.secondary)
			
			Spacer()
			
			Text(self.parkingLocation.prices[i].price)
				.font(.body)
				.fontWeight(.regular)
		}
		.listRowBackground(Color.gray)
		
		Divider()
			.opacity(0.8)
			.padding(.vertical, 4)
	}
}

// Content Preview

struct LocationDetailView_Previews: PreviewProvider {
	static var previews: some View {
		LocationDetailView(parkingLocation: ParkingAreaList.allParkingAreas.first!)
	}
}
