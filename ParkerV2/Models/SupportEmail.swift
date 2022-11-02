//
//  SupportEmail.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/11/02.
//

import Foundation
import UIKit
import SwiftUI

struct SupportEmail {
	let toAddress: String
	let subject: String
	let messageHeader: String
	
	var body: String{"""
		Please Describe Issue Below: 
	"""}
	
	func send(openURL: OpenURLAction){
		let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
		
		guard let url = URL(string: urlString) else { return }
		
		openURL(url) { accepted in
			if !accepted{
				print("This device does not support email!")
			}
		}
	}
}
