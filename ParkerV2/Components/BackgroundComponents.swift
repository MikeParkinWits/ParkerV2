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
