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
	var prices: [Prices] = [Prices(id: 1, timeLow: 0, timeHigh: 0, time: "", price: 0)]
}

struct Prices: Identifiable{
	var id: Int = 0
	
	var timeLow = 0
	var timeHigh = 0
	var time: String = ""
	var price: Int = 0
}
