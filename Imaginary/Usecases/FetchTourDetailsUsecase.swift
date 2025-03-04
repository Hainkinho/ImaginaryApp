//
//
//  FetchTourDetailsUsecase.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation

struct FetchTourDetailsUsecase {
	
	private let networkService: NetworkService
	private let appStateStore: AppStateStore
	
	init(networkService: NetworkService, appStateStore: AppStateStore) {
		self.networkService = networkService
		self.appStateStore = appStateStore
	}
	
	
	func fetch(tourID: TourID) async throws -> TourDetails {
		let tourDetails = try await networkService.fetchTourDetails(forTourID: tourID)
		
		await MainActor.run {
			appStateStore.insert(tourDetails: tourDetails)
		}
		return tourDetails
	}
}
