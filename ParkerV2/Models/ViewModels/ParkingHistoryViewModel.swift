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

//				   print(queryDocumentSnapshot.documentID)
//				print(pricesArray)
					 
					   
				

				return ParkingHistory(id: id, userID: userID, image: image, imageSmall: imageSmall, name: name, location: location, locationLat: locationLat, locationLong: locationLong, date: date, price: price)
			}
			
		}
	}
}
