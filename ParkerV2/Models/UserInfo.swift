//
//  UserInfo.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/11/01.
//

import Foundation
import FirebaseAuth

class UserInfo: ObservableObject {
	enum FBAuthState {
		case undefined, signedOut, signedIn
	}
	
	@Published var isUserAuthenticated: FBAuthState = .undefined
	@Published var user: FBUser = .init(uid: "", name: "", email: "", lastName: "", carMake: "", isParked: false, profileImageUrl: "", currentParkingAreaID: "")
	
	var authStateDidChangeListenerHangle: AuthStateDidChangeListenerHandle?
	
	func configureFirebaseStateDidChange(){
		
		authStateDidChangeListenerHangle = Auth.auth().addStateDidChangeListener({ (_, user) in
			guard var _ = user else {
				self.isUserAuthenticated = .signedOut
				return
			}
			self.isUserAuthenticated = .signedIn
		})
	}
}
