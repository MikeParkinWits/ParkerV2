//
//  MainView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/20.
//

import SwiftUI

struct MainView: View {
	
	init() {
	  UITabBar.appearance().backgroundColor = UIColor.systemBackground
	}
	
	var body: some View {
		TabView {
			HomeView()
				.background(Color(.systemGroupedBackground))
				.tabItem {
					Label("Home", systemImage: "house")
				}

			
//			Add for white tabBar
//				.toolbarBackground(Color.red, for: .tabBar)
//				.toolbar(.visible, for: .tabBar)
//				.accentColor(.red)
			
				
		}
		
//	Add to change tabBar item colour
//		.accentColor(Color.red)

	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
