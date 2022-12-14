//
//  LocationMap.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI
import MapKit

struct LocationMap: View {
	
	var isParkingArea: Bool
	
	var parkingLocation: ParkingArea?
	var parkingHistory: ParkingHistory?
	
	@EnvironmentObject var viewModel: ParkingAreasViewModel
	
	@State var region: MKCoordinateRegion
	
	@State var places: [LocationAnnotations]
	
	@State private var showingAlert = false
	
	@State var url: URL
	
	init(isParkingArea: Bool, at parkingLocation: ParkingArea?, at parkingHistory: ParkingHistory?, viewModel: ParkingAreasViewModel) {
		self.parkingLocation = parkingLocation
		self.parkingHistory = parkingHistory
		self.isParkingArea = isParkingArea
		
		var historyLocationValue: ParkingArea = ParkingArea(id: "", image: "", imageSmall: "", name: "", location: "", locationLat: 0.0, locationLong: 0.0, parkingID: "", prices: [Prices(id: 1, timeLow: 0, timeHigh: 0, time: "", price: 0)])
		
		if !isParkingArea{
			historyLocationValue = viewModel.parkingAreas.first(where: {$0.parkingID == parkingHistory?.parkingAreaId})!
		}
		
		let region = MKCoordinateRegion(
			center: CLLocationCoordinate2D(latitude: isParkingArea ? parkingLocation!.locationLat : historyLocationValue.locationLat, longitude: isParkingArea ? parkingLocation!.locationLong : historyLocationValue.locationLong),
			latitudinalMeters: 750,
			longitudinalMeters: 750
			
		)
		
		let places: [LocationAnnotations]
		
		if(isParkingArea){
			places = [
				LocationAnnotations(name: parkingLocation!.name,
									latitude: parkingLocation!.locationLat,
									longitude: parkingLocation!.locationLong)
			]
		}else{
			places = [
				LocationAnnotations(name: historyLocationValue.name,
									latitude: historyLocationValue.locationLat,
									longitude: historyLocationValue.locationLong)
			]
		}
		
		let url = URL(string: "maps://?saddr=&daddr=\(isParkingArea ? parkingLocation!.locationLat : parkingHistory!.locationLat),\(isParkingArea ? parkingLocation!.locationLong : parkingHistory!.locationLong)")
		
		self._region = State(initialValue: region)
		self._places = State(initialValue: places)
		self._url = State(initialValue: url!)
		self.isParkingArea = isParkingArea
	}
	
	var body: some View {
		VStack{
			
			
			Map(coordinateRegion: $region, interactionModes: [], annotationItems: places){ place in
				MapMarker(coordinate: place.coordinate)
			}
			.onTapGesture {
				showingAlert = true
			}
			//			.innerShadow(color: Color("innerShadow").opacity(0.1), radius: 0.05)
			.cornerRadius(10)
			.shadow(color: Color("shadowColor"), radius: 3)
			
			.frame(maxWidth: .infinity, maxHeight: 250)
			.confirmationDialog("Important message", isPresented: $showingAlert) {
				Button("Open in Maps") { if UIApplication.shared.canOpenURL(url) {
					UIApplication.shared.open(url, options: [:], completionHandler: nil)
				} }
				Button("Cancel", role: .cancel) { }
			}
			
			if(isParkingArea){
				ParkingAreaMapSubHeadline(parkingLocation: parkingLocation!)
			}else{
				ParkingHistoryMapSubHeadline(parkingHistory: parkingHistory!)
			}
			
		}
	}
	

	var filteredLocations: ParkingArea {
//		viewModel.fetchData()
		return viewModel.parkingAreas.first(where: {$0.parkingID == parkingHistory!.parkingAreaId}) ?? ParkingArea(id: "", image: "", imageSmall: "", name: "", location: "", locationLat: 0.0, locationLong: 0.0, parkingID: "", prices: [Prices(id: 1, timeLow: 0, timeHigh: 0, time: "", price: 0)])
	}
	
}

// Declaring Location Annotations Structure (Class)
struct LocationAnnotations: Identifiable {
	let id = UUID()
	let name: String
	let latitude: Double
	let longitude: Double
	var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
}
