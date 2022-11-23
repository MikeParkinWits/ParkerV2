//
//  Locations.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/28.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

struct ParkingArea: Identifiable{
	var id: String = UUID().uuidString
	
	var image: String = ""
	var imageSmall: String = ""
	var name: String = ""
	var location: String = ""
	var locationLat: Double = 0.0
	var locationLong: Double = 0.0
	var parkingID: String = ""
	var prices: [Prices] = [Prices(id: 1, time: "", price: "")]
}

struct Prices: Identifiable{
	var id: Int = 0
	
	var time: String = ""
	var price: String = ""
}

//struct ParkingAreaList{
//	static let allParkingAreas = [
//
//		ParkingArea(image: "test-image", imageSmall: "test-image-square", name: "Parkhurst Strip", location: "Parkhurst", locationLat: -26.13962, locationLong: 28.01743, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R6"), Prices(time: "60 - 120", price: "R10"), Prices(time: "120 - 240", price: "R15"), Prices(time: "240+", price: "R25")]),
//		ParkingArea(image: "test-image-two", imageSmall: "test-image-two-square", name: "44 Stanley", location: "Braamfontein", locationLat: -26.18536, locationLong: 28.01880, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
//		ParkingArea(image: "test-image-three", imageSmall: "test-image-three-square", name: "Parkview Centre", location: "Parkview", locationLat: -26.16024, locationLong: 28.02668, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R2"), Prices(time: "60 - 120", price: "R6"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
//		ParkingArea(image: "test-image-four", imageSmall: "test-image-four-square", name: "Oxford Parks", location: "Dunkeld", locationLat: -26.14145, locationLong: 28.04328, prices: [Prices(time: "0 - 60", price: "Free"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
//		ParkingArea(image: "test-image-five", imageSmall: "test-image-five-square", name: "Trumpet on Keyes", location: "Keyes Avenue", locationLat: -26.14345, locationLong: 28.03645, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R20")]),
//
//
//	]
//}
