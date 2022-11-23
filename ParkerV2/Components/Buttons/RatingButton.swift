//
//  RatingButton.swift
//  ParkerV2
//
//

import SwiftUI

struct RatingButton: View {
	let id: Int
	@Binding var currentlySelectedId: Int
	var image: String
	var colorFill: Color
	
	var body: some View {
		
		Button(action: { self.currentlySelectedId = self.id }, label: {
			Image(systemName: image)
				.font(.headline)
				.frame(maxWidth: 20, maxHeight: 30)
			
				.foregroundColor(id == currentlySelectedId ? colorFill : .gray)
				.fontWeight(.bold)
			
		})
		.buttonStyle(.bordered)
		.tint(id == currentlySelectedId ? colorFill : .gray)

	}
}


struct MyRatingButtons: View {
	@State var currentlySelectedId: Int = 0
	var body: some View {
		HStack {
			RatingButton(id: 1, currentlySelectedId: $currentlySelectedId, image: "hand.thumbsup.fill", colorFill: .blue)
			RatingButton(id: 2, currentlySelectedId: $currentlySelectedId, image: "hand.thumbsdown.fill", colorFill: .red)
		}
	}
}
