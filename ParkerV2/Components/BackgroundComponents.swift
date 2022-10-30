//
//  BackgroundComponents.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/30.
//
// A file created to hold all background elements that are repeated throughout the entire project
//

// IMPORTS

import SwiftUI

// BLUR VIEW - Creates glassmorphism background effect

struct BlurView: UIViewRepresentable {
	let style: UIBlurEffect.Style
	
	func makeUIView(context: Context) -> UIVisualEffectView {
		let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
		
		return view
	}
	
	func updateUIView(_ uiView:UIVisualEffectView, context: Context){}
}
