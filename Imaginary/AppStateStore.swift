//
//
//  AppStateStore.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation


class AppStateStore: ObservableObject {
	
	@Published private(set) var curAppState: AppState
	
	init(initialAppState: AppState) {
		self.curAppState = initialAppState
	}
	

	func insert(tour: Tour) {
		self.curAppState = curAppState.insert(tour: tour)
	}
	
	
	func insert(tourDetails: TourDetails) {
		self.curAppState = curAppState.insert(tourDetails: tourDetails)
	}
}
