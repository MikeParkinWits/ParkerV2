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
//						.onAppear(){
//							self.viewModel.fetchData()
//						}
					
					
					Label("\(filteredLocations.first?.location ?? "")", systemImage: "mappin.and.ellipse")
						.foregroundColor(.secondary)
					
				}
				
				Spacer()
				
				Text("R\(parkingHistory.price)")
					.font(.largeTitle)
					.fontWeight(.bold)
			}
			
			Divider()
				.padding(.vertical, -12)

		}
		.font(.subheadline)
		.padding(.top, 2)
	}
	
	var filteredLocations: [ParkingArea] {
//		viewModel.fetchData()
		return viewModel.parkingAreas.filter({$0.parkingID == parkingHistory.parkingAreaID})
	}
	
}

//struct ParkingHistoryMapSubHeadline_Previews: PreviewProvider {
//	static var previews: some View {
//		ParkingHistoryMapSubHeadline(parkingHistory: ParkingHistoryList.AllParkingHistory.first!)
//	}
//}
