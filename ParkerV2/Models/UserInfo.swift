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
//			FBFirestore.retrieveFBUser(uid: user.uid) { (result) in
//				switch result{
//				case .failure(let error):
//					print(error.localizedDescription)
//				case .success(let user):
//					self.user = user
//				}
//			}
		})
		
//		self.isUserAuthenticated = .signedOut
//		self.isUserAuthenticated = .signedIn
	}
}
