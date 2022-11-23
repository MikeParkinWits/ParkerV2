//
//  NotParkedDrawer.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/11/02.
//

import SwiftUI
import Drawer

// MARK: - Drawer on Home Screen for when parked

struct NotParkedDrawer: View {
	
	@State var heights = [CGFloat(UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height*0.23)), CGFloat(UIScreen.main.bounds.size.height*0.33)]
	
	var body: some View {
		Drawer(startingHeight: CGFloat(UIScreen.main.bounds.size.height*0.33)) {
			ZStack {
				
				Rectangle().fill(.blue.gradient)
					.opacity(0.1)
					.cornerRadius(30)
				
				BlurredBackground(style: .systemMaterial)
					.foregroundColor(Color.black)
					.cornerRadius(30)
					.shadow(color: Color("shadowColor").opacity(0.5), radius: 5)
					.frame(height: (UIScreen.main.bounds.size.height))
				
				VStack(spacing: 5.0) {
					Spacer().frame(height: 4.0)
					RoundedRectangle(cornerRadius: 3.0)
						.foregroundColor(.gray)
						.frame(width: 35.0, height: 6.0)
					
					Spacer().frame(height: 4.0)
					
					VStack(alignment: .leading, spacing: 15) {
						Text("Parking Status")
							.font(.largeTitle)
							.fontWeight(.bold)
							.padding(.bottom, 2)
							.minimumScaleFactor(0.01)
						
						VStack(spacing: 20){
							Image(systemName: "car.fill")
								.resizable()
								.scaledToFit()
								.frame(maxWidth: .infinity, maxHeight: 125)
							
							Text("Not Currently Parked")
								.font(.title3)
								.fontWeight(.semibold)
						}
						.foregroundColor(.secondary)
						.padding(10)
					}
					
					Spacer()
					
				}
				.padding(.horizontal)
				
			}
			
		}
		.rest(at: $heights)
		.impact(.light)
		.spring(50)
		.shadow(radius: 0)
		.multilineTextAlignment(.leading)
	}
}

struct NotParkedDrawer_Previews: PreviewProvider {
    static var previews: some View {
        NotParkedDrawer()
    }
}
