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
	let homeNavigationRouter: HomeNavigationRouter
	
	
	func createAdaptiveHomeNavigationLayout() -> AdaptiveHomeNavigationLayout {
		AdaptiveHomeNavigationLayout(
			homeNavigationRouter: homeNavigationRouter,
			createHomePage: { listButtonConfig in
				self.createHomePage(listButtonConfig: listButtonConfig)
			}, createDetailsPage: { tourID in
				self.createDetailsPage(forTourID: tourID)
			}
		)
	}
	
	func createHomePage(listButtonConfig: HomePageListButtonConfig) -> HomeContainerPage {
		let vm = HomePageViewModel()
		
		vm.subcribe(appStatePublisher: appStateStore.appStateDidChangePublisher)
		vm.update(withNewAppState: appStateStore.curAppState)
		
		return HomeContainerPage(
			vm: vm,
			listButtonConfig: listButtonConfig,
			tappedOnCell: { tour in
				homeNavigationRouter.showTourDetails(forTourID: tour.id)
			}
		)
	}
	
	
	func createDetailsPage(forTourID tourID: TourID) -> DetailsContainerPage {
		let tour = appStateStore.curAppState.toursDict[tourID]! // This must always be true
		
		let vm = DetailsPageViewModel(tour: tour)
		vm.subcribe(appStatePublisher: appStateStore.appStateDidChangePublisher)
		vm.update(withNewAppState: appStateStore.curAppState)
		
		return DetailsContainerPage(vm: vm)
	}
	
}
