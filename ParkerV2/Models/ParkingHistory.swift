//
//  Locations.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/28.
//

import Foundation
import SwiftUI
import Firebase

//struct ParkingHistory: Identifiable{
//	let id: Int
//	let image: String
//	let imageSmall: String
//	let name: String
//	let location: String
//	let locationLat: Double
//	let locationLong: Double
//	let date: String
//	let price: Int
////	let prices: [HistoryLongList]
//}

struct ParkingHistory: Identifiable{
	let id: Int
	let userID: String
	
	let image: String
	let imageSmall: String
	let name: String
	let location: String
	let locationLat: Double
	let locationLong: Double
	let date: String
	let price: Int
	
	let timeParked: Int
	
	let parkingAreaId: String
		
	var guardInfo: [GuardInfo] = [GuardInfo(image: "", name: "", rating: 1)]
	
}

struct GuardInfo: Identifiable{
	let id = UUID()

	let image, name: String
	
	let rating: Int

}
