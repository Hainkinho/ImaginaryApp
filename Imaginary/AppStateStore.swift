//
//
//  AppStateStore.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation
import Combine

class AppStateStore: ObservableObject {
	
	@Published private(set) var curAppState: AppState
	
	var appStateDidChangePublisher: AnyPublisher<AppState, Never> {
		self.$curAppState
			.throttle(for: 0.2, scheduler: DispatchQueue.main, latest: true)
			.removeDuplicates()
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
	init(initialAppState: AppState) {
		self.curAppState = initialAppState
	}
	
	
	func set(tours: [Tour]) {
		self.curAppState = curAppState.set(tours: tours)
	}

	func insert(tour: Tour) {
		self.curAppState = curAppState.insert(tour: tour)
	}
	
	
	func insert(tourDetails: TourDetails) {
		self.curAppState = curAppState.insert(tourDetails: tourDetails)
	}
	
	
	func set(top5TourIDs: [TourID]) {
		self.curAppState = curAppState.set(top5TourIDs: top5TourIDs)
	}
}
