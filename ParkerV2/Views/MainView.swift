//
//  MainView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/20.
//

import SwiftUI

struct MainView: View {
	var body: some View {
		TabView {
			HomeView()
				.tabItem {
					Label("Home", systemImage: "house")
				}
			
//			Add for white tabBar
//				.toolbarBackground(Color.white, for: .tabBar)
//				.toolbar(.visible, for: .tabBar)
			
				
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
