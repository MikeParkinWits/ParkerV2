//
//  LocationDetailView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/28.
//

import SwiftUI
import MapKit

// LOCATION DETAIL VIEW

struct LocationDetailView: View {
	
	var parkingLocation: Locations
	
	var body: some View {
		
		NavigationView{
			VStack(spacing: 15.0) {
				
				DisplayParkingAreaMap(at: parkingLocation)
				
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

// MAP CODE

// Map Location View Code
struct DisplayParkingAreaMap: View {
	
	var parkingLocation: Locations
	
	@State var region: MKCoordinateRegion
	
	@State var places: [LocationAnnotations]
	
	@State private var showingAlert = false
	
	@State var url: URL
	
	init(at parkingLocation: Locations) {
		self.parkingLocation = parkingLocation
		
		let region = MKCoordinateRegion(
			center: CLLocationCoordinate2D(latitude: parkingLocation.locationLat, longitude: parkingLocation.locationLong),
			latitudinalMeters: 750,
			longitudinalMeters: 750
			//			span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
			
		)
		
		let places = [
			LocationAnnotations(name: parkingLocation.name,
								latitude: parkingLocation.locationLat,
								longitude: parkingLocation.locationLong)
		]
		
		let url = URL(string: "maps://?saddr=&daddr=\(parkingLocation.locationLat),\(parkingLocation.locationLong)")
		
		self._region = State(initialValue: region)
		self._places = State(initialValue: places)
		self._url = State(initialValue: url!)
	}
	
	var body: some View {
		Map(coordinateRegion: $region, interactionModes: [], annotationItems: places){ place in
			MapMarker(coordinate: place.coordinate)
		}
		.onTapGesture {
			showingAlert = true
		}
		.innerShadow(color: Color("innerShadow").opacity(0.1), radius: 0.05)
		.cornerRadius(10)
		//				.shadow(color: Color("shadowColor"), radius: 3)
		
		.frame(maxWidth: .infinity, maxHeight: 250)
		.confirmationDialog("Important message", isPresented: $showingAlert) {
			Button("Open in Maps") { if UIApplication.shared.canOpenURL(url) {
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			} }
			Button("Cancel", role: .cancel) { }
		}
		
		HStack {
			Label(parkingLocation.location, systemImage: "mappin.and.ellipse")
			
			Spacer()
			
			Text("0.2km away")
		}
		.font(.subheadline)
		.foregroundColor(.secondary)
		.padding(.bottom, 5)
		.padding(.top, 2)
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

// PRICE CODE

// Single Price Row Cell
struct DisplaySinglePriceRow: View{
	
	var i: Int
	
	var parkingLocation: Locations
	
	init(at parkingLocation: Locations, on i: Int) {
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
		LocationDetailView(parkingLocation: LocationList.nearbyFive.first!)
	}
}
