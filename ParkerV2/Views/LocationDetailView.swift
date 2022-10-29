//
//  LocationDetailView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/28.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
	
	var location: Locations
	
	@State var region: MKCoordinateRegion
	
	@State var places: [LocationAnnotations]
	
	@State private var showingAlert = false
	
	@State var url: URL
	
	init(location: Locations) {
		self.location = location
		
		let region = MKCoordinateRegion(
			center: CLLocationCoordinate2D(latitude: location.locationLat, longitude: location.locationLong),
						latitudinalMeters: 750,
						longitudinalMeters: 750
//			span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
			
		)
		
		let places = [
			LocationAnnotations(name: location.name, latitude: location.locationLat, longitude: location.locationLong)
		]
		
		let url = URL(string: "maps://?saddr=&daddr=\(location.locationLat),\(location.locationLong)")
		
		self._region = State(initialValue: region)
		self._places = State(initialValue: places)
		self._url = State(initialValue: url!)
	}
	
	var body: some View {
		
		NavigationView{
			VStack(spacing: 15.0) {
				Map(coordinateRegion: $region, interactionModes: [], annotationItems: places){ place in
					MapMarker(coordinate: place.coordinate)
				}
				.onTapGesture {
					showingAlert = true
				}
				.cornerRadius(10)
				.shadow(color: Color("shadowColor"), radius: 3)
				.frame(maxWidth: .infinity, maxHeight: 250)
				.confirmationDialog("Important message", isPresented: $showingAlert) {
					Button("Open in Maps") { if UIApplication.shared.canOpenURL(url) {
						UIApplication.shared.open(url, options: [:], completionHandler: nil)
					} }
					Button("Cancel", role: .cancel) { }
			}
//				.padding(.horizontal)
				
				
				HStack {
					Label(location.location, systemImage: "mappin.and.ellipse")
					
					Spacer()
					
					Text("0.2km away")
				}
				.font(.subheadline)
				.foregroundColor(.secondary)
				.padding(.bottom, 5)
//				.padding(.horizontal)
				.padding(.top, 2)
				

				
				VStack(alignment: .leading, spacing: 7){
					Section {
						
						ForEach(0..<location.prices.count, id: \.self){i in
							HStack(spacing: 4){
								Text(self.location.prices[i].time)
									.font(.body)
									.fontWeight(.medium)
								Text("min")
									.font(.body)
									.fontWeight(.medium)
									.foregroundColor(.secondary)

								Spacer()

								Text(self.location.prices[i].price)
									.font(.body)
									.fontWeight(.regular)
							}
							.listRowBackground(Color.gray)
	//						.background(Color.red)


	//						.padding(.vertical, 2)
							Divider()
								.opacity(0.8)
								.padding(.vertical, 4)
						}
						.cornerRadius(20)
//						.listStyle(.sidebar)
	//					.padding(.horizontal, -10)
	//					.padding(.horizontal, -10)

//						.listRowInsets(EdgeInsets())

	//					.scrollContentBackground(.hidden)

//						.padding(.horizontal, 0)

					}
				header: {
					Text("Prices")
						.font(.title2)
						.fontWeight(.bold)
						.padding(.bottom, 5)
				}
					
//					List {
//							Section {
//								ForEach(0..<location.prices.count, id: \.self){i in
//									HStack(spacing: 4){
//										Text(self.location.prices[i].time)
//											.font(.body)
//											.fontWeight(.semibold)
//										Text("min")
//											.font(.body)
//											.fontWeight(.semibold)
//											.foregroundColor(.secondary)
//
//										Spacer()
//
//										Text(self.location.prices[i].price)
//											.font(.body)
//											.fontWeight(.regular)
//									}
////									.listRowBackground(Color.gray)
//			//						.background(Color.red)
//
//
//			//						.padding(.vertical, 2)
//			//						Divider()
//			//							.opacity(0.5)
//								}
//							} header: {
//								Text("Prices")
//									.font(.title)
//									.fontWeight(.bold)
//									.foregroundColor(.primary)
////									.padding(.leading, -10)
//							}
//
////							Section {
////								Text("One")
////								Text("Two")
////								Text("Three")
////							} header: {
////								Text("Second Section Header")
////							} footer: {
////								Text("Tempora distinctio excepturi quasi distinctio est voluptates voluptate et dolor iste nisi voluptatem labore ipsum blanditiis sed sit suscipit est.")
////							}
////
////							Section {
////								Text("1")
////								Text("2")
////								Text("3")
////							} header: {
////								Text("Third Section Header")
////							} footer: {
////								Text("Ea consequatur velit sequi voluptatibus officia maiores ducimus consequatur rerum enim omnis totam et voluptates eius consectetur rerum dolorem quis omnis ut ut.")
////							}
//					}
//					.scrollDisabled(true)
//					.padding(.bottom, -200.0)
//						// This is the only difference.
//						.listStyle(.inset)

					

					


				}
//				.padding(.horizontal, 17)
//				.padding(.vertical, 17)
//				.background(
//					BlurView(style: .systemThinMaterial)
//						.opacity(0.2)
//					.cornerRadius(20)
//					.shadow(color: Color("shadowColor").opacity(0.8), radius: 1)
//				)


				
				Spacer()


			}
			.padding(.horizontal)
			.padding(.top, 15)
		}

		
		
		
		
	}
}

struct LocationDetailView_Previews: PreviewProvider {
	static var previews: some View {
		LocationDetailView(location: LocationList.nearbyFive.first!)
	}
}

//Declaring Location Annotation Class Object
struct LocationAnnotations: Identifiable {
	let id = UUID()
	let name: String
	let latitude: Double
	let longitude: Double
	var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
}
