//
//
//  HomeContainerPage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import SwiftUI


extension View {
	
	func setupHomePageNavbar(tappedMoreButton: @escaping () -> Void) -> some View {
		self
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					HStack {
						Image(Constants.companyLogoImageString)
							.resizable()
							.scaledToFit()
							.frame(width: 40, height: 40)
						
						Text(Constants.appName)
							.fontWeight(.bold)
					}
				}
				
				ToolbarItem(placement: .topBarTrailing) {
					Button(action: tappedMoreButton) {
						Image(systemName: "ellipsis")
							.rotationEffect(.init(degrees: 90))
							.foregroundStyle(.black)
							.frame(width: 44, height: 44)  // Ensures the button is easily tappable
							.background(Color.white.opacity(0.00001))
					}
				}
			}
	}
	
	
	func setupLandscapeHomeNavbar(tourTitle: String?, tappedMoreButton: @escaping () -> Void) -> some View {
		self
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					HStack {
						Image(Constants.companyLogoImageString)
							.resizable()
							.scaledToFit()
							.frame(width: 40, height: 40)
						
						if let tourTitle = tourTitle {
							Text(tourTitle)
								.fontWeight(.bold)
						} else {
							Text(Constants.appName)
								.fontWeight(.bold)
						}
					}
				}
				
				ToolbarItem(placement: .topBarTrailing) {
					Button(action: tappedMoreButton) {
						Image(systemName: "ellipsis")
							.rotationEffect(.init(degrees: 90))
							.foregroundStyle(.black)
							.frame(width: 44, height: 44)  // Ensures the button is easily tappable
							.background(Color.white.opacity(0.00001))
					}
				}
			}
	}
}


struct CustomBackButtonToolbar: ViewModifier {
	
	@Environment(\.dismiss) var dismiss
	
	let tourTitle: String?
	
	func body(content: Content) -> some View {
		content
			.navigationBarBackButtonHidden()
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					HStack {
						Button(action: {
							dismiss.callAsFunction()
						}) {
							Image(systemName: "arrow.left")
								.foregroundStyle(.black)
								.fontWeight(.bold)
						}
						
						Text(tourTitle ?? "")
							.fontWeight(.bold)
					}
				}
			}
	}
}


class HomeNavigationRouter: ObservableObject {
	
	@Published var selectedTourID: TourID?
	
	func showTourDetails(forTourID tourID: TourID ) {
		self.selectedTourID = tourID
	}
}

struct AdaptiveHomeNavigationLayout: View {
	
	@Environment(\.horizontalSizeClass) private var sizeClass
	
	@StateObject var homeNavigationRouter: HomeNavigationRouter
	
	let createHomePage: (HomePageListButtonConfig) -> HomeContainerPage
	let createDetailsPage: (TourID) -> DetailsContainerPage
	
	let getTourTitle: (TourID) -> String?
	
	var body: some View {
		if sizeClass == .compact {
			NavigationStack {
				createHomePage(.NavigationLink)
					.navigationBarTitleDisplayMode(.inline)
					.setupHomePageNavbar(tappedMoreButton: {
						// TODO: Add logic here. The assignment doesn't specify details, so this needs clarification.
					})
					.navigationDestination(for: TourID.self) { tourID in
						createDetailsPage(tourID)
							.modifier(CustomBackButtonToolbar(tourTitle: getTourTitle(tourID)))
					}
			}
		} else {
			NavigationStack {
				HStack(spacing: 0) {
					createHomePage(.Button(action: { tourID in
						homeNavigationRouter.showTourDetails(forTourID: tourID)
					}))
					
					VStack {
						if let selectedTourID = homeNavigationRouter.selectedTourID {
							createDetailsPage(selectedTourID)
						} else {
							Image(Constants.companyLogoImageString)
								.resizable()
								.frame(width: 100, height: 100)
						}
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				}
				.setupLandscapeHomeNavbar(tourTitle: selectedTourTitle, tappedMoreButton: {
					// TODO: Add logic here. The assignment doesn't specify details, so this needs clarification.
				})
			}
		}
	}
	
	private var selectedTourTitle: String? {
		guard let tourID = homeNavigationRouter.selectedTourID else {
			return nil
		}
		return getTourTitle(tourID)
	}
}
