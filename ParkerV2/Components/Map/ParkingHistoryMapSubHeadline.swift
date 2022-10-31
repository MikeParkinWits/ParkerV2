//
//  ParkingHistoryMapSubHeadline.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI

struct ParkingHistoryMapSubHeadline: View{
	
	var parkingHistory: ParkingHistory
	
	var body: some View{
		VStack(spacing: 25.0) {
			HStack {
				VStack(alignment: .leading, spacing: 1.0){
					Text(parkingHistory.name)
						.font(.title2)
						.fontWeight(.bold)
						.padding(.bottom, 5)
					
					Label(parkingHistory.location, systemImage: "mappin.and.ellipse")
						.foregroundColor(.secondary)
					
				}
				
				Spacer()
				
				Text("R\(parkingHistory.price)")
					.font(.largeTitle)
					.fontWeight(.bold)
			}

		}
		.font(.subheadline)
		.padding(.bottom, 20)
		.padding(.top, 2)
	}
}

struct ParkingHistoryMapSubHeadline_Previews: PreviewProvider {
	static var previews: some View {
		ParkingHistoryMapSubHeadline(parkingHistory: ParkingHistoryList.AllParkingHistory.first!)
	}
}
