//
//  BlurredBackground.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI

// BLUR VIEW - Creates glassmorphism background effect

struct BlurredBackground: UIViewRepresentable {
	let style: UIBlurEffect.Style
	
	func makeUIView(context: Context) -> UIVisualEffectView {
		let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
		
		return view
	}
	
	func updateUIView(_ uiView:UIVisualEffectView, context: Context){}
}
