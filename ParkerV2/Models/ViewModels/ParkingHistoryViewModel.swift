//
//  ParkingHistoryViewModel.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/11/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class ParkingHistoryViewModel: ObservableObject{
	@Published var parkingHistory = [ParkingHistory]()
	@Published var unwrapped = false
		
//	var userInfoID: String
//	
//	init(userInfo: UserInfo){
//		self.userInfoID = userInfo.user.uid
//	}
	
	private var db = Firestore.firestore()
	
	func fetchData() {
		db.collection("history").addSnapshotListener { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else{
				print ("No documents")
				return
			}
						
			self.parkingHistory = documents.map { (queryDocumentSnapshot) -> ParkingHistory in
				let data = queryDocumentSnapshot.data()
				
				let id = data["id"] as? Int ?? 0
				let userID = data["userID"] as? String ?? ""
				
				let image = data["image"] as? String ?? ""
				let imageSmall = data["imageSmall"] as? String ?? ""
				let name = data["name"] as? String ?? ""
				let location = data["location"] as? String ?? ""
				let locationLat = data["locationLat"] as? Double ?? 0.0
				let locationLong = data["locationLong"] as? Double ?? 0.0
				let date = data["date"] as? String ?? ""
				let price = data["price"] as? Int ?? 0
				let timeParked = data["timeParked"] as? Int ?? 0
				
				let guardInfo = data["guardInfo"] as? [String: [String: Any]]
				
				var guardArray = [GuardInfo]()
				if let guardInfo = guardInfo {
				var count: Int = 0
					for guards in guardInfo{
						let guardName = guards.value["name"] as? String ?? ""
						let guardImage = guards.value["image"] as? String ?? ""
						let guardRating = guards.value["rating"] as? Int ?? 1
						count += 1
						
						if (count == guardInfo.count){
							self.unwrapped = true
						}
						
						guardArray.append(GuardInfo(image: guardImage, name: guardName, rating: guardRating))
						
					}
				}

//				   print(queryDocumentSnapshot.documentID)
//				print(pricesArray)
				
				
				return ParkingHistory(id: id, userID: userID, image: image, imageSmall: imageSmall, name: name, location: location, locationLat: locationLat, locationLong: locationLong, date: date, price: price, timeParked: timeParked, guardInfo: guardArray)
			}
			
		}
	}
}
