//
//  HomeView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/19.
//

import SwiftUI

struct HomeView: View {
	var body: some View {
		
		VStack(alignment: .leading) {
			HStack {
				Text("Nearby Parking Areas")
					.font(.title3)
					.fontWeight(.semibold)
				
				Spacer()
				
				Text("See all")
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			.padding(.horizontal)
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 20) {
					ForEach(0..<5){ index in
						VStack(alignment: .leading){
							
								Image("test-image")
									.resizable()
									.scaledToFit()
									.frame(minHeight: 100, maxHeight: 150)
									.cornerRadius(8)
									.shadow(color: Color("shadowColor"), radius: 5)
									.overlay(
										Label("Braamfontein, Johannesburg", systemImage: "mappin.and.ellipse")
											.font(.footnote)
											.fontWeight(.regular)
											.foregroundColor(.white)
											.frame(maxWidth: .infinity, alignment: .leading)
											.background(Color.black.blur(radius: 10))
											.padding(6)
											.lineLimit(1)
											.minimumScaleFactor(0.8)
										, alignment: .bottomLeading)
							
							
							Text("44 Stanley")
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
				.padding(.horizontal)
			}
			
			
			
		}
		
		
		
		
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
