//
//
//  HomeContainerPage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import SwiftUI

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
					}
//					.navigationDestination(item: $homeNavigationRouter.selectedTourID) { tourID in
//						createDetailsPage(tourID)
//					}
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
				.setupHomePageNavbar(tappedMoreButton: {
					// TODO: Add logic here. The assignment doesn't specify details, so this needs clarification.
				})
			}
		}
	}
}
