//
//  SinglePriceRow.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI

// Single Price Row Cell
struct SinglePriceRow: View{
	
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

struct SinglePriceRow_Previews: PreviewProvider {
	static var previews: some View {
		SinglePriceRow(at: ParkingAreasViewModel().parkingAreas.first!, on: 1)
	}
}
