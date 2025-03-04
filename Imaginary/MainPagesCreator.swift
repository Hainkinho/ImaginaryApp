//
//
//  MainPagesCreator.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation

struct MainPagesCreator {
	
	let appStateStore: AppStateStore
	
	func createHomePage() -> HomePage {
		let tours = appStateStore.curAppState.allTours
		
		return HomePage(tours: tours)
	}
	
	
	func createDetailsPage(forTourID tourID: TourID) -> DetailsPage {
		let tour = appStateStore.curAppState.toursDict[tourID] ?? .createExample(withID: "0")
		let tourDetails = appStateStore.curAppState.tourDetailsDict[tourID] ?? .createExample(withID: "0")
		
		return DetailsPage(
			showcaseImageURL: tourDetails.fullResImageURL,
			title: tour.title,
			description: tourDetails.longDescription,
			isBookable: true,
			startDate: tour.startDate,
			endDate: tour.endDate
		)
	}
	
}
