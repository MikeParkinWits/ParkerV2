//
//  BigCarouselCard.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI

import FirebaseStorage

struct BigCarouselCard: View {
	
	var location: ParkingArea
	
	init(for location: ParkingArea){
		self.location = location
	}		
	
	var body: some View {
		
		//Look at adding inner shadow to image for depth effect: https://www.hackingwithswift.com/articles/253/how-to-use-inner-shadows-to-simulate-depth-with-swiftui-and-core-motion
		
		NavigationLink {
			ParkingAreaDetailView(parkingLocation: location)
				.navigationBarTitle(location.name)
			
		} label: {
			VStack(alignment: .leading){
				
				Image(location.image)
					.resizable()
					.scaledToFit()
					.frame(maxHeight: CGFloat(UIScreen.main.bounds.size.height*0.2))
					.cornerRadius(8)
					.padding(.top, 5)
					.shadow(color: Color("shadowColor"), radius: 3)
					.overlay(
						Label(location.location, systemImage: "mappin.and.ellipse")
							.font(.footnote)
							.fontWeight(.regular)
							.foregroundColor(.white)
							.frame(maxWidth: .infinity, alignment: .leading)
							.background(Color.black.blur(radius: 10))
							.padding(6)
							.lineLimit(1)
							.minimumScaleFactor(0.8)
						, alignment: .bottomLeading)
				
				
				Text(location.name)
					.font(.subheadline)
					.fontWeight(.bold)
					.foregroundColor(.primary)
				
				Text("0.2km")
					.font(.footnote)
					.fontWeight(.regular)
					.foregroundColor(.secondary)
			}
			
		}
	}
}

// Content Preview

struct BigCarouselCard_Previews: PreviewProvider {
	static var previews: some View {
		BigCarouselCard(for: ParkingAreasViewModel().parkingAreas.first!)
	}
}
