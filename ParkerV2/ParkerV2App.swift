//
//  ParkerV2App.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/19.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
				   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
	FirebaseApp.configure()
	  
	return true
  }
}

@main
struct ParkerV2App: App {
	
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	
	var userInfo = UserInfo()
	var viewModel = ParkingAreasViewModel()
	var viewModelObserved = ParkingHistoryViewModel()
	
    var body: some Scene {
        WindowGroup {
			MainView()
				.environmentObject(userInfo)
				.environmentObject(viewModel)
				.environmentObject(viewModelObserved)
        }
    }
}
