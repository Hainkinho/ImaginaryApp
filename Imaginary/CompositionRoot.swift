//
//
//  CompositionRoot.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation

struct CompositionRootResult {
	let mainPagesCreator: MainPagesCreator
}


struct CompositionRoot {
	
	
	func assembleAppsObjectGraph() async -> CompositionRootResult {
		
		let appStateStore = AppStateStore(initialAppState: .empty)
		
		let networkService = NetworkService()
		let fetchTourDetailsUsecase = FetchTourDetailsUsecase(
			networkService: networkService,
			appStateStore: appStateStore
		)
		let fetchAllToursUsecase = FetchAllToursUsecase(
			networkService: networkService,
			appStateStore: appStateStore
		)
		
		let homeNavigationRouter = HomeNavigationRouter()
		
		let mainPagesCreator = MainPagesCreator(
			appStateStore: appStateStore,
			homeNavigationRouter: homeNavigationRouter,
			fetchAllToursUsecase: fetchAllToursUsecase,
			fetchTourDetailsUsecase: fetchTourDetailsUsecase
		)
		
		let tours = (try? await networkService.fetchAllTours()) ?? []
		let top5Tours = (try? await networkService.fetchTop5Tours()) ?? []
		
		
		// MARK: - Set final AppState in AppStateStore
		
		appStateStore.set(tours: tours)
		
		let top5TourIDs = top5Tours.map(\.id)
		appStateStore.set(top5TourIDs: top5TourIDs)
		
		return CompositionRootResult(mainPagesCreator: mainPagesCreator)
	}
}
