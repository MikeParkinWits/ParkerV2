//
//  MainView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/20.
//

import SwiftUI

struct MainView: View {
	
	@EnvironmentObject var userInfo: UserInfo
	
	init() {
		UITabBar.appearance().backgroundColor = UIColor.systemBackground
	}
	
	var body: some View {
		
		Group{
			if userInfo.isUserAuthenticated == .undefined {
				Text("Loading...")
			}
			else if (userInfo.isUserAuthenticated == .signedOut){
				LoginView()
			}
			else if (userInfo.isUserAuthenticated == .signedIn){
				TabView {
					HomeView()
						.tabItem {
							Label("Home", systemImage: "house")
						}
					
					ParkingHistoryView()
						.tabItem {
							Label("History", systemImage: "parkingsign.circle")
						}
					
					ProfileView()
						.tabItem {
							Label("Profile", systemImage: "person.fill")
						}
					
					
					//			Add for white tabBar
					//				.toolbarBackground(Color.red, for: .tabBar)
					//				.toolbar(.visible, for: .tabBar)
					//				.accentColor(.red)
					
					
				}
				
				//	Add to change tabBar item colour
				//		.accentColor(Color.red)		}
				
			}
		}
		.onAppear(perform: {self.userInfo.configureFirebaseStateDidChange()})
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView().environmentObject(UserInfo())
	}
}
