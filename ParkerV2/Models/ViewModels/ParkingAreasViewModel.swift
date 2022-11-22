//
//  ParkingAreasViewModel.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/11/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class ParkingAreasViewModel: ObservableObject{
	@Published var parkingAreas = [ParkingArea]()
	@Published var unwrapped = false
	
	private var db = Firestore.firestore()
	
	func fetchData() {
		db.collection("parkingAreas").addSnapshotListener { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else{
				print ("No documents")
				return
			}
			
			self.parkingAreas = documents.map { (queryDocumentSnapshot) -> ParkingArea in
				let data = queryDocumentSnapshot.data()
				
				let image = data["image"] as? String ?? ""
				let imageSmall = data["imageSmall"] as? String ?? ""
				let name = data["name"] as? String ?? ""
				let location = data["location"] as? String ?? ""
				let locationLat = data["locationLat"] as? Double ?? 0.0
				let locationLong = data["locationLong"] as? Double ?? 0.0
				
				let prices = data["price"] as? [String: [String: Any]]
				
				var pricesArray = [Prices]()
				if let prices = prices {
				var count: Int = 0
					for price in prices{
						let parkingPrice = price.value["price"] as? String ?? ""
						let parkingTime = price.value["time"] as? String ?? ""
						let parkingInt = price.value["id"] as? Int ?? 1
						count += 1
						
						if (count == prices.count){
							self.unwrapped = true
						}
						
						pricesArray.append(Prices(id: parkingInt, time: parkingTime, price: parkingPrice))
						
					}
				}

//				   print(queryDocumentSnapshot.documentID)
//				print(pricesArray)
					 
					   
				pricesArray.sort { $0.id < $1.id }
				

				return ParkingArea(image: image, imageSmall: imageSmall, name: name, location: location, locationLat: locationLat, locationLong: locationLong, prices: pricesArray)
			}
			
		}
	}
}
