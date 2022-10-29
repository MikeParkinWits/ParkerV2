//
//  HomeView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/19.
//

import SwiftUI
import Drawer
import ParallaxSwiftUI

struct HomeView: View {
	
//	CGFloat(600),
	
	@State var heights = [CGFloat(UIScreen.main.bounds.size.height*0.33), CGFloat(UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height*0.23))]
	
	@State private var didTapThumbsUp:Bool = false
	@State private var didTapThumbsDown:Bool = false
	
	var locations: [Locations] = LocationList.nearbyFive
	
	var body: some View {
		
		
		ZStack{
			
			VStack() {
				
				NavigationView{
					ZStack{
						//Potential refactor into seperate struct later
						VStack(alignment: .leading){
							
							Text("Good Afternoon")
								.font(.largeTitle)
								.fontWeight(.bold)
								.multilineTextAlignment(.leading)
								.padding(.horizontal)
								.padding(.top, 40)
								.padding(.bottom, 5)
							
							HStack {
								Text("Nearby Parking Areas")
									.font(.title3)
									.fontWeight(.semibold)
								
								Spacer()
								
								Text("See all")
									.font(.subheadline)
									.foregroundColor(.secondary)
							}
							.padding(.horizontal)
							
							ScrollView(.horizontal, showsIndicators: false) {
								HStack(spacing: 20) {
									ForEach(locations.dropLast(locations.count - 5), id: \.id){ location in
										
										//Refactor into seperate struct later
										
										//Look at adding inner shadow to image for depth effect: https://www.hackingwithswift.com/articles/253/how-to-use-inner-shadows-to-simulate-depth-with-swiftui-and-core-motion
										
										NavigationLink {
											LocationDetailView(location: location)
												.navigationBarTitle(location.name)

										} label: {
											VStack(alignment: .leading){
												
												Image(location.image)
													.resizable()
													.scaledToFit()
													.frame(maxHeight: CGFloat(UIScreen.main.bounds.size.height*0.2))
													.cornerRadius(8)
													.padding(.top, 5)
													.shadow(color: Color("shadowColor"), radius: 3)
													.overlay(
														Label(location.location, systemImage: "mappin.and.ellipse")
															.font(.footnote)
															.fontWeight(.regular)
															.foregroundColor(.white)
															.frame(maxWidth: .infinity, alignment: .leading)
															.background(Color.black.blur(radius: 10))
															.padding(6)
															.lineLimit(1)
															.minimumScaleFactor(0.8)
														, alignment: .bottomLeading)
													
												
												Text(location.name)
													.font(.subheadline)
													.fontWeight(.bold)
													.foregroundColor(.primary)
												
												
												Text("0.2km")
													.font(.footnote)
													.fontWeight(.regular)
													.foregroundColor(.secondary)
											}
//											.frame(height: CGFloat(UIScreen.main.bounds.size.height*0.26))
										}

										

										
										
										
									}
								}
								.padding(.horizontal)
							}
						
//							Spacer()
//								.frame(height: CGFloat(UIScreen.main.bounds.size.height*0.33))
							Spacer()
						}
	//					.navigationTitle("Good Afternoon")
						
						Drawer {
							ZStack {
								BlurView(style: .systemMaterial)
									.foregroundColor(Color.black)
									.cornerRadius(30)
									.shadow(color: Color("shadowColor").opacity(0.5), radius: 5)
									.frame(height: (UIScreen.main.bounds.size.height))
								
								//https://www.hackingwithswift.com/books/ios-swiftui/colors-and-frames
								
								//https://github.com/maustinstar/swiftui-drawer/blob/master/Docs/Reference.md
								
								
								//							No Blur
								//
								//							RoundedRectangle(cornerRadius: 30)
								//								.foregroundColor(.white)
								//								.shadow(radius: 100)
								//								.frame(height: 800)
								
								VStack(spacing: 5.0) {
									Spacer().frame(height: 4.0)
									RoundedRectangle(cornerRadius: 3.0)
										.foregroundColor(.gray)
										.frame(width: 35.0, height: 6.0)
									
									Spacer().frame(height: 4.0)
									
									VStack(alignment: .leading, spacing: 15) {
										Text("Parking Status")
											.font(.title)
											.fontWeight(.bold)
											.padding(.bottom, 2)
											.minimumScaleFactor(0.01)
										
										HStack{
											
											VStack(alignment: .leading, spacing: 5.0){
												Text("Time Parked")
													.font(.title3)
													.fontWeight(.semibold)
												
												Text("43 Minutes")
													.fontWeight(.regular)
											}
											
											Spacer()
											
											Text("R8")
												.font(.largeTitle)
												.fontWeight(.bold)
											
										}
										
										HStack{
											
											
											VStack(alignment: .leading, spacing: 7.5){
												Text("Guard")
													.font(.title3)
													.fontWeight(.semibold)
												
												HStack(alignment: .top) {
													Image("test-profile-image")
														.resizable()
														.scaledToFit()
														.frame(minHeight: 60, maxHeight: 60)
														.cornerRadius(8)
													
													VStack(alignment: .leading, spacing: 5.0) {
														Text("John Smith")
															.font(.headline)
															.fontWeight(.regular)
														
														Label("Location", systemImage: "mappin.and.ellipse")
															.font(.subheadline)
															.fontWeight(.regular)
															.foregroundColor(.secondary)
													}
													
													Spacer()
													
													HStack{
														
														Button{
															print("Button tapped!")
														}label: {
															Image(systemName: "hand.thumbsdown.fill")
																.font(.headline)
																.frame(maxWidth: 20, maxHeight: 30)
															
																.foregroundColor(.gray)
																.fontWeight(.bold)
														}
														.buttonStyle(.bordered)
														.tint(.gray)
														
														Button{
															print("Button tapped!")
														}label: {
															Image(systemName: "hand.thumbsup.fill")
																.font(.headline)
																.frame(maxWidth: 20, maxHeight: 30)
															
																.foregroundColor(.gray)
																.fontWeight(.bold)
														}
														.buttonStyle(.bordered)
														.tint(.gray)
														

													}

												}
												
											}
											
											

											
										}
										
										Button{
											print("Button tapped!")
										}label: {
											Label("Report an Issue", systemImage: "exclamationmark.octagon.fill")
												.font(.headline)
												.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.04))
											
												.foregroundColor(.white)
												.fontWeight(.bold)
										}
										.buttonStyle(.borderedProminent)
										.tint(.red)
		//								.padding(.top, 8)
										

										
										
										
										
									}
		//							.padding(.horizontal, 35)
		//							.padding(.vertical, 15)
		//							.background(
		//								BlurView(style: .systemMaterial)
		//
		//								.foregroundColor(Color.black)
		//								.foregroundStyle(
		//										.blue.gradient.shadow(
		//											.inner(color: .black, radius: 10)
		//										)
		//									)
		//							 .cornerRadius(20)
										
									 
		//							 .shadow(color: Color("shadowColor").opacity(0.3), radius: 2)
		//							 .padding(.horizontal)


									 
		//							)
									
									Divider()
										.padding(.vertical, 10)

									
									
									VStack(alignment: .leading, spacing: 3){
										Group {
											Text("Location Details")
												.font(.title)
											.fontWeight(.bold)
											
											Text("Location")
												.font(.subheadline)
												.foregroundColor(.secondary)
												.padding(.bottom, 15)
										}
										
										
										
										

										VStack(alignment: .leading, spacing: 5){
											Text("Price")
												.font(.title3)
												.fontWeight(.semibold)
												.padding(.bottom, 1)

											
											ForEach(0..<5){ index in
											
												HStack{
													Text("Time")
													
													Spacer()
													
													Text("Price")
												}
												.padding(.bottom, 5)

												
											}
										}
										
										Button{
											print("Button tapped!")
										}label: {
											Text("View Location")
												.font(.headline)
												.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.04))
											
												.foregroundColor(.blue)
												.fontWeight(.bold)
										}
										.buttonStyle(.bordered)
										.tint(.gray)
										.padding(.top, 8)

									

									}
									
									
									Spacer()
										
									
								}
								.padding(.horizontal)
								
								
							}
							
						}
						.rest(at: $heights)
						.impact(.light)
						.spring(50)
						.shadow(radius: 0)
						.multilineTextAlignment(.leading)
					}

				}
				
				
				
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}


struct BlurView: UIViewRepresentable {
	let style: UIBlurEffect.Style
	
	func makeUIView(context: Context) -> UIVisualEffectView {
		let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
		
		return view
	}
	
	func updateUIView(_ uiView:UIVisualEffectView, context: Context){
		
		
	}
}
