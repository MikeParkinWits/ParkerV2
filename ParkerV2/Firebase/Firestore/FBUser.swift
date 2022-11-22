//
//  FBUser.swift
//
//

import Foundation

struct FBUser {
    let uid: String
    let name: String
    let email: String
	let lastName: String
	let carMake: String
	let isParked: Bool
	let profileImageUrl: String
    
    // App Specific properties can be added here
    
	init(uid: String, name: String, email: String, lastName: String, carMake: String, isParked: Bool, profileImageUrl: String) {
        self.uid = uid
        self.name = name
        self.email = email
		self.lastName = lastName
		self.carMake = carMake
		self.isParked = isParked
		self.profileImageUrl = profileImageUrl
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
        
        // Make sure you also initialize any app specific properties if you have them

        
        self.init(uid: uid,
                  name: name,
                  email: email,
				  lastName: lastName,
				  carMake: carMake,
				  isParked: isParked,
				  profileImageUrl: profileImageUrl
                  // Dont forget any app specific ones here too
        )
    }
    
	static func dataDict(uid: String, name: String, email: String, lastName: String, carMake: String, isParked: Bool, profileImageUrl: String) -> [String: Any] {
        var data: [String: Any]
        
        // If name is not "" this must be a new entry so add all first time data
        if name != "" {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.name: name,
                FBKeys.User.email: email,
				FBKeys.User.lastName: lastName,
				FBKeys.User.carMake: carMake,
				FBKeys.User.isParked: isParked,
				FBKeys.User.profileImageUrl: profileImageUrl
                // Again, include any app specific properties that you want stored on creation
            ]
        } else {
            // This is a subsequent entry so only merge uid and email so as not
            // to overrwrite any other data.
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.email: email
            ]
        }
        return data
    }
}
