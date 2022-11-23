//
//  ParkingAreaMapSubHeadline.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI

struct ParkingAreaMapSubHeadline: View{
	
	var parkingLocation: ParkingArea
	
	var body: some View{
		HStack {
			Label(parkingLocation.location, systemImage: "mappin.and.ellipse")
			
			Spacer()
			
//			Text("0.2km away")
		}
		.font(.subheadline)
		.foregroundColor(.secondary)
		.padding(.bottom, 5)
		.padding(.top, 2)
	}
}

struct ParkingAreaMapSubHeadline_Previews: PreviewProvider {
	static var previews: some View {
		ParkingAreaMapSubHeadline(parkingLocation: ParkingAreasViewModel().parkingAreas.first!)
	}
}
