//
//  FBUser.swift
//
//

// MARK: - Creating User

import Foundation

struct FBUser {
	let uid: String
	let name: String
	let email: String
	let lastName: String
	let carMake: String
	let isParked: Bool
	let profileImageUrl: String
	let currentParkingAreaID: String
	
	init(uid: String, name: String, email: String, lastName: String, carMake: String, isParked: Bool, profileImageUrl: String, currentParkingAreaID: String) {
		self.uid = uid
		self.name = name
		self.email = email
		self.lastName = lastName
		self.carMake = carMake
		self.isParked = isParked
		self.profileImageUrl = profileImageUrl
		self.currentParkingAreaID = currentParkingAreaID
	}
	
}

extension FBUser {
	init?(documentData: [String : Any]) {
		let uid = documentData[FBKeys.User.uid] as? String ?? ""
		let name = documentData[FBKeys.User.name] as? String ?? ""
		let email = documentData[FBKeys.User.email] as? String ?? ""
		let lastName = documentData[FBKeys.User.lastName] as? String ?? ""
		let carMake = documentData[FBKeys.User.carMake] as? String ?? ""
		let isParked = documentData[FBKeys.User.isParked] as? Bool ?? false
		let profileImageUrl = documentData[FBKeys.User.profileImageUrl] as? String ?? ""
		let currentParkingAreaID = documentData[FBKeys.User.currentParkingAreaID] as? String ?? ""
		
		self.init(uid: uid,
				  name: name,
				  email: email,
				  lastName: lastName,
				  carMake: carMake,
				  isParked: isParked,
				  profileImageUrl: profileImageUrl,
				  currentParkingAreaID: currentParkingAreaID
				  
		)
	}
	
	static func dataDict(uid: String, name: String, email: String, lastName: String, carMake: String, isParked: Bool, profileImageUrl: String, currentParkingAreaID: String) -> [String: Any] {
		var data: [String: Any]
		
		if name != "" {
			data = [
				FBKeys.User.uid: uid,
				FBKeys.User.name: name,
				FBKeys.User.email: email,
				FBKeys.User.lastName: lastName,
				FBKeys.User.carMake: carMake,
				FBKeys.User.isParked: isParked,
				FBKeys.User.profileImageUrl: profileImageUrl,
				FBKeys.User.currentParkingAreaID: currentParkingAreaID
				
			]
		} else {
			
			data = [
				FBKeys.User.uid: uid,
				FBKeys.User.email: email
			]
		}
		return data
	}
}
