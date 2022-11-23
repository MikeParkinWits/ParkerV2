//
//  FBKeys.swift
//
//

// MARK: - Imports

import Foundation

// MARK: - Declaring the User Database Variables

enum FBKeys {
	
	enum CollectionPath {
		static let users = "users"
	}
	
	enum User {
		static let uid = "uid"
		static let name = "name"
		static let email = "email"
		static let lastName = "lastName"
		static let carMake = "carMake"
		static let isParked = "isParked"
		static let profileImageUrl = "profileImageUrl"
		static let currentParkingAreaID = "currentParkingAreaID"
		
	}
}
