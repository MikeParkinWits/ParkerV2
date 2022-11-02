//
//  BottomDrawer.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/10/31.
//

import SwiftUI
import Drawer

struct BottomDrawer: View {
	
	@State var heights = [CGFloat(UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height*0.23)), CGFloat(UIScreen.main.bounds.size.height*0.33)]
	
	@State var heightsTall = [CGFloat(UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height*0.23))]
	
	@State private var didTapThumbsUp:Bool = false
	@State private var didTapThumbsDown:Bool = false
	
	var parkingLocation: ParkingArea
	
	@State private var showingAlert = false
	
	@Environment(\.openURL) var openURL
	var email = SupportEmail(toAddress: "1894979@students.wits.ac.za", subject: "Support Email", messageHeader: "Describe your issue below")
	
	var body: some View {
		Drawer(startingHeight: CGFloat(UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height*0.23))) {
			ZStack {
				
				Rectangle().fill(.blue.gradient)
					.opacity(0.1)
					.cornerRadius(30)
				
				BlurredBackground(style: .systemMaterial)
					.foregroundColor(Color.black)
					.cornerRadius(30)
					.shadow(color: Color("shadowColor").opacity(0.5), radius: 5)
					.frame(height: (UIScreen.main.bounds.size.height))
				
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
							.font(.largeTitle)
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
						
//						Divider()
//						//						.padding(.vertical, 10)
//							.padding(.vertical, 5)
//												Group {
//													Text("Location Details")
//														.font(.title3)
//														.fontWeight(.bold)
//
//						//							Text("Location")
//						//								.font(.subheadline)
//						//								.foregroundColor(.secondary)
//						//								.padding(.bottom, 5)
//												}
//												.padding(.bottom, 1)
						
						NavigationLink {
							ParkingAreaDetailView(parkingLocation: ParkingAreaList.allParkingAreas.first!)
								.navigationBarTitle(ParkingAreaList.allParkingAreas.first!.name)
						} label: {
							
							VStack(alignment: .leading, spacing: 5){
							 Text("Parking Price")
								 .font(.title3)
								 .fontWeight(.semibold)
								 .padding(.bottom, 8)
 //								.padding(.top, 10)
							 
							 ForEach(0..<parkingLocation.prices.count, id: \.self){currentRow in
								 
								 SinglePriceRow(at: parkingLocation, on: currentRow)
								 
							 }
						 }
						 .padding()
						 .background(
							BlurredBackground(style: .systemThinMaterial)
							 .cornerRadius(20)
							 .shadow(color: Color("shadowColor").opacity(0.4), radius: 5)
 )
						 .padding(.vertical, 10)
						}
						.buttonStyle(.plain)

						
//						HStack{
//							Button{
//								print("Button tapped!")
//							}label: {
//								Text("View Location")
//									.font(.headline)
//									.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.04))
//
//									.foregroundColor(.blue)
//									.fontWeight(.bold)
//							}
//							.buttonStyle(.bordered)
//							.tint(.gray)
//							.padding(.vertical, 7)
							
							Button{
								print("Button tapped!")
								showingAlert = true
							}label: {
								Label("Report an Issue", systemImage: "exclamationmark.octagon.fill")
									.font(.headline)
									.frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.size.height*0.04))
								
									.foregroundColor(.white)
									.fontWeight(.bold)
							}
							.confirmationDialog("Important message", isPresented: $showingAlert) {
								Button("Send a Report using Mail") {
									
									email.send(openURL: openURL)
									
								}
								
								Button("Cancel", role: .cancel) { }
							}
						
							.buttonStyle(.borderedProminent)
							.tint(.red)
							.padding(.vertical, 3)
						
						
					}
					
					
//					Divider()
////						.padding(.vertical, 10)
//						.padding(.vertical, 5)
					
					VStack(alignment: .leading, spacing: 3){
//						Group {
//							Text("Location Details")
//								.font(.title)
//								.fontWeight(.bold)
//
////							Text("Location")
////								.font(.subheadline)
////								.foregroundColor(.secondary)
////								.padding(.bottom, 5)
//						}
//						.padding(.bottom, 5)
						

						}


//					}
					
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

struct BottomDrawer_Previews: PreviewProvider {
    static var previews: some View {
        BottomDrawer(parkingLocation: ParkingAreaList.allParkingAreas.first!)
    }
}
