//
//  HomeView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/19.
//

import SwiftUI
import Drawer

struct HomeView: View {
	
	@State var heights = [CGFloat(UIScreen.main.bounds.size.height*0.4),CGFloat(600), CGFloat(UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height*0.18))]
	
	var body: some View {
		

		ZStack{
			
				VStack() {
					
					NavigationView{
						//Potential refactor into seperate struct later
						VStack{
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
									ForEach(0..<5){ index in
										
										//Refactor into seperate struct later
										
										//Look at adding inner shadow to image for depth effect: https://www.hackingwithswift.com/articles/253/how-to-use-inner-shadows-to-simulate-depth-with-swiftui-and-core-motion
										VStack(alignment: .leading){
											
											Image("test-image-two")
												.resizable()
												.scaledToFit()
												.frame(minHeight: 100, maxHeight: 150)
												.cornerRadius(8)
												.padding(.top, 5)
												.shadow(color: Color("shadowColor"), radius: 3)
												.overlay(
													Label("Braamfontein, Johannesburg", systemImage: "mappin.and.ellipse")
														.font(.footnote)
														.fontWeight(.regular)
														.foregroundColor(.white)
														.frame(maxWidth: .infinity, alignment: .leading)
														.background(Color.black.blur(radius: 10))
														.padding(6)
														.lineLimit(1)
														.minimumScaleFactor(0.8)
													, alignment: .bottomLeading)
											
											
											Text("44 Stanley")
												.font(.subheadline)
												.fontWeight(.bold)
												.foregroundColor(.primary)
											
											
											Text("0.2km")
												.font(.footnote)
												.fontWeight(.regular)
												.foregroundColor(.secondary)
										}
										
										
									}
								}
								.padding(.horizontal)
							}
							
						}
						.navigationTitle("Good Afternoon")
					}
					
					Drawer {
						ZStack {
							BlurView(style: .systemMaterial)
								.foregroundColor(Color.black)
								.cornerRadius(30)
								.shadow(color: Color("shadowColor").opacity(0.5), radius: 5)
								.frame(height: 1000)
							
							//https://www.hackingwithswift.com/books/ios-swiftui/colors-and-frames
							
							//https://github.com/maustinstar/swiftui-drawer/blob/master/Docs/Reference.md
							
							
//							No Blur
//
//							RoundedRectangle(cornerRadius: 30)
//								.foregroundColor(.white)
//								.shadow(radius: 100)
//								.frame(height: 800)
							
							VStack(alignment: .center, spacing: 5.0) {
								Spacer().frame(height: 4.0)
								RoundedRectangle(cornerRadius: 3.0)
									.foregroundColor(.gray)
									.frame(width: 35.0, height: 6.0)
								
								Spacer().frame(height: 4.0)
								
								Text("Hello")
									.foregroundStyle(.secondary)
								Spacer()
								
							}
						}
					}
					.rest(at: $heights)
					.impact(.light)
					.spring(50)
					.shadow(radius: 0)
					
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
