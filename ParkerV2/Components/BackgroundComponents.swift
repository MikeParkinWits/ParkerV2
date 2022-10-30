//
//  BackgroundComponents.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/30.
//
// A file created to hold all background elements that are repeated throughout the entire project
//

// IMPORTS

import SwiftUI
import MapKit

// BLUR VIEW - Creates glassmorphism background effect

struct BlurView: UIViewRepresentable {
	let style: UIBlurEffect.Style
	
	func makeUIView(context: Context) -> UIVisualEffectView {
		let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
		
		return view
	}
	
	func updateUIView(_ uiView:UIVisualEffectView, context: Context){}
}


// PARKING AREA CODE

// Small Card View

struct SmallSingleCard: View {
	
	var location: Locations?
	var parkingHistory: ParkingHistory?
	
	var isParkingAreaCard = false
	
	init(isParkingCard: Bool, containingArea location: Locations?, containingHistory parkingHistory: ParkingHistory?){
		self.isParkingAreaCard = isParkingCard
		self.location = location
		self.parkingHistory = parkingHistory
		
		
	}
	
	var body: some View {
		NavigationLink {
			if (isParkingAreaCard){
				LocationDetailView(parkingLocation: location!)
					.navigationBarTitle(location!.name)
			}else{
				ParkingHistoryDetailView(parkingHistory: parkingHistory!)
					.navigationBarTitle("#\(parkingHistory!.id)", displayMode: .inline)
			}
		} label: {
			HStack(alignment: .center){
				Image(isParkingAreaCard ? location!.imageSmall : parkingHistory!.imageSmall)
					.resizable()
					.scaledToFit()
					.frame(width: 70, height: 70)
					.cornerRadius(10)
					.shadow(color: Color("shadowColor").opacity(0.7), radius: 2)
				
				VStack(alignment: .leading, spacing: 1.0){
					Text(isParkingAreaCard ? location!.name : parkingHistory!.name)
						.font(.headline)
						.fontWeight(.bold)
					
					Text(isParkingAreaCard ? location!.location : "\(parkingHistory!.id)")
						.font(.subheadline)
						.fontWeight(.semibold)
						.foregroundStyle(.secondary)
					
					Spacer()
					
					Text(isParkingAreaCard ? "0.2km Away" : parkingHistory!.date)
						.font(.subheadline)
						.fontWeight(.regular)
						.foregroundStyle(.secondary)
				}
				
				Spacer()
				
				if (!isParkingAreaCard){
					Text("R\(parkingHistory!.price)")
						.font(.largeTitle)
						.fontWeight(.bold)
				}
				
			}
			.frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
			.padding(10)
			.background(
				Rectangle().fill(Color("listBackgroundColour"))
					.cornerRadius(15)
					.shadow(color: Color("shadowColor").opacity(0.8), radius: 3)
			)
		}
		.padding(.horizontal)
		.padding(.top, 13)
		.buttonStyle(.plain)
	}
}

// MAP CODE

// Map Location View Code
struct DisplayParkingAreaMap: View {
	
	var isParkingArea: Bool
	
	var parkingLocation: Locations?
	var parkingHistory: ParkingHistory?
	
	@State var region: MKCoordinateRegion
	
	@State var places: [LocationAnnotations]
	
	@State private var showingAlert = false
	
	@State var url: URL
	
	init(isParkingArea: Bool, at parkingLocation: Locations?, at parkingHistory: ParkingHistory?) {
		self.parkingLocation = parkingLocation
		self.parkingHistory = parkingHistory
		
		let region = MKCoordinateRegion(
			center: CLLocationCoordinate2D(latitude: isParkingArea ? parkingLocation!.locationLat : parkingHistory!.locationLat, longitude: isParkingArea ? parkingLocation!.locationLong : parkingHistory!.locationLong),
			latitudinalMeters: 750,
			longitudinalMeters: 750
			//			span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
			
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
				LocationAnnotations(name: parkingHistory!.name,
									latitude: parkingHistory!.locationLat,
									longitude: parkingHistory!.locationLong)
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
			
			if(isParkingArea){
				ParkingAreaMapSubHeadline(parkingLocation: parkingLocation!)
			}else{
				ParkingHistoryMapSubHeadline(parkingHistory: parkingHistory!)
			}
		}
	}
}

struct ParkingAreaMapSubHeadline: View{
	
	var parkingLocation: Locations
	
	var body: some View{
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
