//
//  Locations.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/28.
//

import Foundation
import SwiftUI

struct ParkingHistory: Identifiable{
	let id: Int
	let image: String
	let imageSmall: String
	let name: String
	let location: String
	let locationLat: Double
	let locationLong: Double
	let date: String
	let price: Int
//	let prices: [HistoryLongList]
}

//struct HistoryLongList: Identifiable{
//	let id = UUID()
//
//	let time, price: String
//
//}

struct ParkingHistoryList{
	static let AllParkingHistory = [
		
		ParkingHistory(id: 1, image: "test-image-two", imageSmall: "test-image-two-square", name: "44 Stanleyy", location: "Braam", locationLat: 1, locationLong: 1, date: "22/10/2022", price: 8)
		
		
	]
}
