//
//  ImageUploader.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/11/22.
//

import Firebase
import UIKit
import FirebaseStorage

struct ImageUploader {
	static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
		guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
		
		let filename = NSUUID().uuidString
		let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
		
		ref.putData(imageData, metadata: nil) { _, error in
			if let error = error {
				print("DEBUG: Failed to uplaod image with error: \(error.localizedDescription)")
			}
			
			ref.downloadURL { imageUrl, _ in
				guard let imageUrl = imageUrl?.absoluteString else { return }
				
				completion(imageUrl)
			}
		}
	}
}
