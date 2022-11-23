//
//  ParkingHistoryMapSubHeadline.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI

struct ParkingHistoryMapSubHeadline: View{
	
	var parkingHistory: ParkingHistory
	
	@EnvironmentObject var viewModel: ParkingAreasViewModel
	
	var body: some View{
		VStack() {
			HStack {
				VStack(alignment: .leading, spacing: 1.0){
					
					Text("\(filteredLocations.first?.name ?? "")")
						.font(.title2)
						.fontWeight(.bold)
						.padding(.bottom, 5)
					
					Label("\(filteredLocations.first?.location ?? "")", systemImage: "mappin.and.ellipse")
						.foregroundColor(.secondary)
					
				}
				
				Spacer()
				
				ForEach(0..<filteredLocationsNotArr.prices.count, id: \.self){currentRow in
					if (parkingHistory.timeParked >= filteredLocationsNotArr.prices[currentRow].timeLow && parkingHistory.timeParked < filteredLocationsNotArr.prices[currentRow].timeHigh) {
						
						Text(filteredLocationsNotArr.prices[currentRow].price == 0 ? "Free" : "R\(filteredLocationsNotArr.prices[currentRow].price)")
							.font(.largeTitle)
							.fontWeight(.bold)
					}
					
				}
				
			}
			
			Divider()
				.padding(.vertical, -12)
			
		}
		.font(.subheadline)
		.padding(.top, 2)
	}
	
	var filteredLocations: [ParkingArea] {
		//		viewModel.fetchData()
		return viewModel.parkingAreas.filter({$0.parkingID == parkingHistory.parkingAreaId})
	}
	
	var filteredLocationsNotArr: ParkingArea {
		//		viewModel.fetchData()
		return viewModel.parkingAreas.first(where: {$0.parkingID == parkingHistory.parkingAreaId}) ?? ParkingArea(id: "", image: "", imageSmall: "", name: "", location: "", locationLat: 0.0, locationLong: 0.0, parkingID: "", prices: [Prices(id: 1, timeLow: 0, timeHigh: 0, time: "", price: 0)])
	}
	
}
