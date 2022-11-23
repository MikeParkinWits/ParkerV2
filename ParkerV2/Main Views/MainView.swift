//
//  MainView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/20.
//

import SwiftUI

enum AnimationState {
	case compress
	case expand
	case normal
}

struct MainView: View {
	
	@EnvironmentObject var userInfo: UserInfo
	
	init() {
		UITabBar.appearance().backgroundColor = UIColor.systemBackground
	}
	
	var body: some View {
		ZStack {
			
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
						
					}
					
				}
			}
			.onAppear(perform: {self.userInfo.configureFirebaseStateDidChange()})
			
			SplashScreen()
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView().environmentObject(UserInfo())
	}
}

struct SplashScreen: View {
	
	// Splash Screen Animation Variables
	@State private var animationState: AnimationState = .normal
	
	@State private var done: Bool = false
	func calculate() -> Double {
		switch animationState {
		case .compress:
			return 0.18
		case .expand:
			return 10.0
		case .normal:
			return 0.2
		}
	}
	
	var body: some View {
		VStack {
			Image("ParkerSplashScreen_Large")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.scaleEffect(calculate())
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color("SplashScreenBackgroundColour"))
		.opacity(done ? 0 : 1)
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
				withAnimation(.spring()) {
					animationState = .compress
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
						withAnimation(.spring()) {
							animationState = .expand
							withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0)) {
								done = true
							}
						}
					}
				}
			}
		}
	}
}
