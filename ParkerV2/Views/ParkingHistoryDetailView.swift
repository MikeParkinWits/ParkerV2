//
//  ParkingHistoryDetailView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/30.
//

import SwiftUI

struct ParkingHistoryDetailView: View {
	
	var parkingHistory: ParkingHistory
	
    var body: some View {
		VStack() {
			DisplayParkingAreaMap(isParkingArea: false, at: nil, at: parkingHistory)

			
			
			HStack {
				VStack(alignment: .leading, spacing: 1.0){
					Text("Date Parked")
						.font(.title3)
						.fontWeight(.semibold)
						.padding(.bottom, 5)
					
					Text(parkingHistory.date)
						.font(.body)
						.fontWeight(.regular)
						.padding(.bottom, 5)
					
					
				}
				
				Spacer()
				
				VStack(alignment: .leading, spacing: 1.0){
					Text("Time Parked")
						.font(.title3)
						.fontWeight(.semibold)
						.padding(.bottom, 5)
					
					Text("43 Minutes")
						.font(.body)
						.fontWeight(.regular)
						.padding(.bottom, 5)
					
					
				}
			}
			
			HStack{
				VStack(alignment: .leading, spacing: 7.5){
					Text("Guard")
						.font(.title3)
						.fontWeight(.semibold)
					
					HStack(alignment: .top) {
						Image("test-profile-image")
							.resizable()
							.scaledToFit()
							.frame(minHeight: 60, maxHeight: 60)
							.cornerRadius(8)
						
						VStack(alignment: .leading, spacing: 5.0) {
							Text("John Smith")
								.font(.headline)
								.fontWeight(.regular)
						}
						
						Spacer()
						
						HStack{
							
							Button{
								print("Button tapped!")
							}label: {
								Image(systemName: "hand.thumbsdown.fill")
									.font(.headline)
									.frame(maxWidth: 20, maxHeight: 30)
								
									.foregroundColor(.gray)
									.fontWeight(.bold)
							}
							.buttonStyle(.bordered)
							.tint(.gray)
							
							Button{
								print("Button tapped!")
							}label: {
								Image(systemName: "hand.thumbsup.fill")
									.font(.headline)
									.frame(maxWidth: 20, maxHeight: 30)
								
									.foregroundColor(.gray)
									.fontWeight(.bold)
							}
							.buttonStyle(.bordered)
							.tint(.gray)
							
						}
					}
				}
			
			}
			
			Spacer()
			
			Button{
				print("Button tapped!")
			}label: {
				Label("Report an Issue", systemImage: "exclamationmark.octagon.fill")
					.font(.headline)
					.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.04))
				
					.foregroundColor(.white)
					.fontWeight(.bold)
			}
			.buttonStyle(.borderedProminent)
			.tint(.red)
			.padding(.bottom, 20)
			
		}
		.padding(.horizontal)
    }
}

struct ParkingHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
		ParkingHistoryDetailView(parkingHistory: ParkingHistoryList.AllParkingHistory.first!)
    }
}
