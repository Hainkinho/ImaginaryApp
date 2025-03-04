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
	
	func createHomePage() -> HomeContainerPage {
		let vm = HomePageViewModel()
		
		vm.subcribe(appStatePublisher: appStateStore.$curAppState.eraseToAnyPublisher())
		vm.update(withNewAppState: appStateStore.curAppState)
		
		return HomeContainerPage(vm: vm)
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
