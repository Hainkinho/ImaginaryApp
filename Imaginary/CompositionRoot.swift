//
//
//  CompositionRoot.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation

struct CompositionRootResult {
	
}


struct CompositionRoot {
	
	
	func assembleAppsObjectGraph() async -> CompositionRootResult {
		
		let appStateStore = AppStateStore(initialAppState: .empty)
		
		// TODO: fetch tours and add it to the appStateStore
		
		#if DEBUG
		try? await Task.sleep(for: .seconds(2))
		#endif
		
		addDummyData(toAppStateStore: appStateStore)
		
		return CompositionRootResult()
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
