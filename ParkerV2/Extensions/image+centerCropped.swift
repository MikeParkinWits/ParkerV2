//
//  image+centerCropped.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/11/22.
//

import Foundation
import SwiftUI
import Kingfisher

extension Image {
	func centerCropped() -> some View {
		GeometryReader { geo in
			self
			.resizable()
			.scaledToFill()
			.frame(width: geo.size.width, height: geo.size.height)
			.clipped()
		}
	}
}

extension KFImage {
	func centerCropped() -> some View {
		GeometryReader { geo in
			self
			.resizable()
			.scaledToFill()
			.frame(width: geo.size.width, height: geo.size.height)
			.clipped()
		}
	}
}
