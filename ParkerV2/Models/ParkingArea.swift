//
//  Locations.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/28.
//

import Foundation
import SwiftUI

struct ParkingArea: Identifiable{
	let id: Int
	let image: String
	let imageSmall: String
	let name: String
	let location: String
	let locationLat: Double
	let locationLong: Double
	let prices: [Prices]
}

struct Prices: Identifiable{
	let id = UUID()
	
	let time, price: String
	
}

struct ParkingAreaList{
	static let allParkingAreas = [
		
		ParkingArea(id: 1, image: "test-image-two", imageSmall: "test-image-two-square", name: "44 Stanley", location: "Braamfontein", locationLat: -26.18536, locationLong: 28.01880, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		ParkingArea(id: 2, image: "test-image", imageSmall: "test-profile-image", name: "44 Stan", location: "Braamfontein", locationLat: -26.18536, locationLong: 28.01880, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		ParkingArea(id: 3, image: "test-image-two", imageSmall: "test-profile-image", name: "44 Stanley", location: "Braamfontein", locationLat: -26.18536, locationLong: 28.01880, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		ParkingArea(id: 4, image: "test-image-two", imageSmall: "test-profile-image", name: "44 Stanley", location: "Braamfontein", locationLat: -26.18536, locationLong: 28.01880, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		ParkingArea(id: 5, image: "test-image-two", imageSmall: "test-profile-image", name: "44 Stanley", location: "Braamfontein", locationLat: -26.18536, locationLong: 28.01880, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		ParkingArea(id: 6, image: "test-image-two", imageSmall: "test-profile-image", name: "44 Stanley", location: "Braamfontein", locationLat: -26.18536, locationLong: 28.01880, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		
		
	]
}
