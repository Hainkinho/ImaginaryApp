//
//
//  DetailsPageViewModel.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Combine


class DetailsPageViewModel: ObservableObject {
	
	@Published var tour: Tour
	@Published var tourDetails: TourDetails? = nil
	
	let tourID: TourID
	private var subscription: AnyCancellable? = nil
	
	init(tour: Tour) {
		self.tour = tour
		self.tourID = tour.id
	}
	
	func subcribe(appStatePublisher: AnyPublisher<AppState, Never>) {
		self.subscription = appStatePublisher
			.sink { [weak self] newAppState in
				self?.update(withNewAppState: newAppState)
			}
	}
	
	
	func update(withNewAppState newAppState: AppState) {
		if let newTour = newAppState.toursDict[self.tourID] {
			self.tour = newTour
		}
		self.tourDetails = newAppState.tourDetailsDict[self.tourID]
	}
	
}
