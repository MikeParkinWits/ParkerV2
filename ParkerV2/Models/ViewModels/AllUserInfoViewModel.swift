//
//  AllUserInfoViewModel.swift
//  ParkerV2
//
//


import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class AllUserInfoViewModel: ObservableObject{
	@Published var allUsers = [AllUserInfo]()
	@Published var unwrapped = false
	
	
	func fetchData() {
		var db = Firestore.firestore()
		
		db.collection("users").addSnapshotListener { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else{
				print ("No documents")
				return
			}
			
			self.allUsers = documents.map { (queryDocumentSnapshot) -> AllUserInfo in
				let data = queryDocumentSnapshot.data()
				
				let emailAddress = data["email"] as? String ?? ""
				
				return AllUserInfo(emailAddress: emailAddress)
			}
			
		}
	}
}
