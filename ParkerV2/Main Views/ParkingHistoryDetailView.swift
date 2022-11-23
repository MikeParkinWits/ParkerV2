//
//  ParkingHistoryDetailView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/30.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ParkingHistoryDetailView: View {
	
	var parkingHistory: ParkingHistory
	
	@State private var showingAlert = false
	
	@Environment(\.openURL) var openURL
	var email = SupportEmail(toAddress: "1894979@students.wits.ac.za", subject: "Support Email", messageHeader: "Describe your issue below")
	
	@EnvironmentObject var viewModel: ParkingAreasViewModel

	var body: some View {
		VStack() {
			
			LocationMap(isParkingArea: false, at: filteredLocations, at: parkingHistory)
				

			
			
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
					
					Text("\(parkingHistory.timeParked) Minutes")
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
						Image(parkingHistory.guardInfo[0].image)
							.resizable()
							.scaledToFit()
							.frame(minHeight: 60, maxHeight: 60)
							.cornerRadius(8)
						
						VStack(alignment: .leading, spacing: 5.0) {
							Text(parkingHistory.guardInfo[0].name)
								.font(.headline)
								.fontWeight(.regular)
							
							Text("\(parkingHistory.guardInfo[0].rating)%")
								.font(.subheadline)
								.fontWeight(.regular)
								.foregroundColor(.secondary)
						}
						
						Spacer()
						
						HStack{
							

							
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
							
						}
					}
				}
			
			}
			
			Spacer()
			
			Button{
				print("Button tapped!")
				showingAlert = true
			}label: {
				Label("Report an Issue", systemImage: "exclamationmark.octagon.fill")
					.font(.headline)
					.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.04))
				
					.foregroundColor(.white)
					.fontWeight(.bold)
			}
			.confirmationDialog("Important message", isPresented: $showingAlert) {
				Button("Send a Report using Mail") {
					
					email.send(openURL: openURL)
					
				}
				
				Button("Cancel", role: .cancel) { }
			}
			
			.buttonStyle(.borderedProminent)
			.tint(.red)
			.padding(.bottom, 20)
			
		}
		.padding(.horizontal)
    }
	
	var filteredLocations: ParkingArea {
//		viewModel.fetchData()
		return viewModel.parkingAreas.first(where: {$0.parkingID == parkingHistory.parkingAreaID}) ?? ParkingArea(id: "", image: "", imageSmall: "", name: "", location: "", locationLat: 0.0, locationLong: 0.0, parkingID: "", prices: [Prices(id: 0, time: "", price: "")])
	}
	
}

//struct ParkingHistoryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//		ParkingHistoryDetailView(parkingHistory: ParkingHistoryList.AllParkingHistory.first!)
//    }
//}
