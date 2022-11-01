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
    
    // App Specific properties can be added here
    
	init(uid: String, name: String, email: String, lastName: String) {
        self.uid = uid
        self.name = name
        self.email = email
		self.lastName = lastName
    }

}

extension FBUser {
    init?(documentData: [String : Any]) {
        let uid = documentData[FBKeys.User.uid] as? String ?? ""
        let name = documentData[FBKeys.User.name] as? String ?? ""
        let email = documentData[FBKeys.User.email] as? String ?? ""
		let lastName = documentData[FBKeys.User.lastName] as? String ?? ""
        
        // Make sure you also initialize any app specific properties if you have them

        
        self.init(uid: uid,
                  name: name,
                  email: email,
				  lastName: lastName
                  // Dont forget any app specific ones here too
        )
    }
    
	static func dataDict(uid: String, name: String, email: String, lastName: String) -> [String: Any] {
        var data: [String: Any]
        
        // If name is not "" this must be a new entry so add all first time data
        if name != "" {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.name: name,
                FBKeys.User.email: email,
				FBKeys.User.lastName: lastName
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
