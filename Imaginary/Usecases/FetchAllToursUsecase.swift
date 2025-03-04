//
//
//  FetchAllToursUsecase.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation

struct FetchAllToursUsecase {
	
	private let networkService: NetworkService
	private let appStateStore: AppStateStore
	
	init(networkService: NetworkService, appStateStore: AppStateStore) {
		self.networkService = networkService
		self.appStateStore = appStateStore
	}
	
	
	func fetch() async throws -> [Tour] {
		let tours = try await networkService.fetchAllTours()
		let top5Tours = try await networkService.fetchTop5Tours()
		
		await MainActor.run {
			appStateStore.set(tours: tours)
			
			let top5TourIDs = top5Tours.map(\.id)
			appStateStore.set(top5TourIDs: top5TourIDs)
		}
		return tours
	}
}
