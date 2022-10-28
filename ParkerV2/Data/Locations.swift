//
//  Locations.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/28.
//

import Foundation
import SwiftUI

struct Locations: Identifiable{
	let id: Int
	let image: String
	let name: String
	let location: String
	let locationLat: Double
	let locationLong: Double
	let pricesTime: [String]
	let prices: [Int]
}

struct LocationList{
	static let nearbyFive = [
	
		Locations(id: 1, image: "test-image-two", name: "44 Stanley", location: "Braamfontein", locationLat: 0.00, locationLong: 0.00, pricesTime: ["0 - 15", "15 - 60"], prices: [0, 5]),
		
		Locations(id: 2, image: "test-image", name: "44 Stanley", location: "Braamfontein", locationLat: 0.00, locationLong: 0.00, pricesTime: ["0 - 15", "15 - 60"], prices: [0, 5]),
		
		Locations(id: 3, image: "test-image-two", name: "44 Stanley", location: "Braamfontein", locationLat: 0.00, locationLong: 0.00, pricesTime: ["0 - 15", "15 - 60"], prices: [0, 5]),
		
		Locations(id: 4, image: "test-image-two", name: "44 Stanley", location: "Braamfontein", locationLat: 0.00, locationLong: 0.00, pricesTime: ["0 - 15", "15 - 60"], prices: [0, 5]),
		
		Locations(id: 5, image: "test-image-two", name: "44 Stanley", location: "Braamfontein", locationLat: 0.00, locationLong: 0.00, pricesTime: ["0 - 15", "15 - 60"], prices: [0, 5]),
		
		Locations(id: 6, image: "test-image-two", name: "44 Stanley", location: "Braamfontein", locationLat: 0.00, locationLong: 0.00, pricesTime: ["0 - 15", "15 - 60"], prices: [0, 5])
		
	]
}
