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
		
		let homeNavigationRouter = HomeNavigationRouter()
		
		let mainPagesCreator = MainPagesCreator(
			appStateStore: appStateStore,
			homeNavigationRouter: homeNavigationRouter,
			fetchTourDetailsUsecase: fetchTourDetailsUsecase
		)
		
		let tours = (try? await networkService.fetchAllTours()) ?? []
		let top5Tours = (try? await networkService.fetchTop5Tours()) ?? []
		
		
		tours.forEach({ tour in
			appStateStore.insert(tour: tour)
		})
		
		let top5TourIDs = top5Tours.map(\.id)
		appStateStore.set(top5TourIDs: top5TourIDs)
		
		return CompositionRootResult(mainPagesCreator: mainPagesCreator)
	}
	
	
	private func addDummyData(toAppStateStore appStateStore: AppStateStore) {
		(0 ... 100)
			.map {
				Tour(id: TourID(value: "\($0)"), title: "Title", shortDescription: "Descrition", snapshotImageURL: URL.placeholderImageURL, startDate: Date().addingTimeInterval(-100), endDate: Date(), price: 100)
			}
			.forEach { tour in
				appStateStore.insert(tour: tour)
			}
		
		(0 ... 100)
			.map {
				TourDetails(id: TourID(value: "\($0)"), longDescription: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam", fullResImageURL: URL.placeholderImageURL)
			}
			.forEach { tourDetails in
				appStateStore.insert(tourDetails: tourDetails)
			}
	}
}
