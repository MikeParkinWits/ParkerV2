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

struct ParkingArea: Identifiable{
	let id: String = UUID().uuidString
	
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

struct ParkingArea1: Identifiable{
	let id: String = UUID().uuidString
	
	let image: String
	let imageSmall: String
	let name: String
	let location: String
	let locationLat: Double
	let locationLong: Double
	
	let prices: [Prices]
}

struct ParkingAreaList{
	static let allParkingAreas = [
		
		ParkingArea(image: "test-image", imageSmall: "test-image-square", name: "Parkhurst Strip", location: "Parkhurst", locationLat: -26.13962, locationLong: 28.01743, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R6"), Prices(time: "60 - 120", price: "R10"), Prices(time: "120 - 240", price: "R15"), Prices(time: "240+", price: "R25")]),
		ParkingArea(image: "test-image-two", imageSmall: "test-image-two-square", name: "44 Stanley", location: "Braamfontein", locationLat: -26.18536, locationLong: 28.01880, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		ParkingArea(image: "test-image-three", imageSmall: "test-image-three-square", name: "Parkview Centre", location: "Parkview", locationLat: -26.16024, locationLong: 28.02668, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R2"), Prices(time: "60 - 120", price: "R6"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		ParkingArea(image: "test-image-four", imageSmall: "test-image-four-square", name: "Oxford Parks", location: "Dunkeld", locationLat: -26.14145, locationLong: 28.04328, prices: [Prices(time: "0 - 60", price: "Free"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R15")]),
		ParkingArea(image: "test-image-five", imageSmall: "test-image-five-square", name: "Trumpet on Keyes", location: "Keyes Avenue", locationLat: -26.14345, locationLong: 28.03645, prices: [Prices(time: "0 - 15", price: "Free"), Prices(time: "15 - 60", price: "R5"), Prices(time: "60 - 120", price: "R8"), Prices(time: "120 - 240", price: "R10"), Prices(time: "240+", price: "R20")]),
		
		
	]
}

class ParkingAreasViewModel: ObservableObject{
	@Published var parkingAreas = [ParkingArea]()
	
	private var db = Firestore.firestore()
	
	func fetchData() {
		db.collection("parkingAreas").addSnapshotListener { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else{
				print ("No documents")
				return
			}
			
//			for document in querySnapshot!.documents {
//
//			  if document == document {
//
//				  self.db.collection("parkingAreas").document(document.documentID).collection("prices").getDocuments() { (querySnapshot, err) in
//					  if let err = err {
//						  print("Error getting documents: \(err)")
//					  } else {
//						  for document in querySnapshot!.documents {
//							  print("\(document.documentID) => \(document.data())")
//						  }
//					  }
//				  }
//
//			   print(document.documentID)
//				 }
//				   }
			
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
					for price in prices{
						let parkingPrice = price.value["price"] as? String ?? ""
						let parkingTime = price.value["time"] as? String ?? ""
						
						pricesArray.append(Prices(time: parkingTime, price: parkingPrice))
					}
				}
								
//				let prices = data["prices"] as? [Prices]
					  
//				self.db.collection("parkingAreas").document(queryDocumentSnapshot.documentID).collection("prices").getDocuments() { (querySnapshot, err) in
//						  if let err = err {
//							  print("Error getting documents: \(err)")
//						  } else {
//							  for document in querySnapshot!.documents {
//								  print("\(document.documentID) => \(document.data())")
//								  let prices = Prices(time: document.data()["time"] as! String, price: document.data()["price"] as! String)
//								  print("\(prices)")
//							  }
//						  }
//					  }
					  
				   print(queryDocumentSnapshot.documentID)
				print(pricesArray)
					 
					   
				
				
				return ParkingArea(image: image, imageSmall: imageSmall, name: name, location: location, locationLat: locationLat, locationLong: locationLong, prices: pricesArray)
			}
		}
	}
}

//class ParkingAreaPriceViewModel: ObservableObject{
//	@Published var parkingAreas = [ParkingArea1]()
//
//	private var db = Firestore.firestore()
//
//	func fetchData() {
//		db.collection("parkingAreas").addSnapshotListener { (querySnapshot, error) in
//			guard let documents = querySnapshot?.documents else{
//				print ("No documents")
//				return
//			}
//
//			for document in querySnapshot!.documents {
//
//			  if document == document {
//			   print(document.documentID)
//				 }
//				   }
//
//			self.parkingAreas = documents.map { (queryDocumentSnapshot) -> ParkingArea1 in
//				let data = queryDocumentSnapshot.data()
//
//				let image = data["image"] as? String ?? ""
//				let imageSmall = data["imageSmall"] as? String ?? ""
//				let name = data["name"] as? String ?? ""
//				let location = data["location"] as? String ?? ""
//				let locationLat = data["locationLat"] as? Double ?? 0.0
//				let locationLong = data["locationLong"] as? Double ?? 0.0
//				let prices = data["price"] as? [String] ?? []
//
//				return ParkingArea1(image: image, imageSmall: imageSmall, name: name, location: location, locationLat: locationLat, locationLong: locationLong, prices: ["o"])
//			}
//		}
//	}
//}



class ParkingAreaPriceViewModel: ObservableObject{
	@Published var prices = [Prices]()

//	var name: String
//
//	init(name: String) {
//		self.name = name
//	}

	private var db = Firestore.firestore()

	func fetchData() {
		db.collection("parkingAreas").document("FnERlo0azYlXTBPF1j3q").collection("prices").addSnapshotListener { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else{
				print ("No documents")
				return
			}

			self.prices = documents.map { (queryDocumentSnapshot) -> Prices in
				let data = queryDocumentSnapshot.data()

				let time = data["time"] as? String ?? ""
				let price = data["price"] as? String ?? ""

				return Prices(time: time, price: price)
			}
		}
	}
}
