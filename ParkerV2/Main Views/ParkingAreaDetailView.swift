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

struct ParkingAreaDetailView: View {
	
	var parkingLocation: ParkingArea
	
	@EnvironmentObject var viewModel: ParkingAreasViewModel
	
	var body: some View {
		
		NavigationView{
			VStack(spacing: 15.0) {
				
				LocationMap(isParkingArea: true, at: parkingLocation, at: nil, viewModel: viewModel)
				
				VStack(alignment: .leading, spacing: 7){

					Text("Prices")
						.font(.title2)
						.fontWeight(.bold)
						.padding(.bottom, 5)
						
						ForEach(0..<parkingLocation.prices.count, id: \.self){currentRow in
							
							SinglePriceRow(at: parkingLocation, on: currentRow)
							
						}
				}
				
				Spacer()
				
			}
			.padding(.horizontal)
			.padding(.top, 15)
			
		}
	}
}

// Content Preview

struct LocationDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ParkingAreaDetailView(parkingLocation: ParkingAreasViewModel().parkingAreas.first!)
	}
}
