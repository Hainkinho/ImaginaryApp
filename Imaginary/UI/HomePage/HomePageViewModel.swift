//
//
//  HomePageViewModel.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	


import Combine

enum HomePageItemsFilter: CaseIterable {
	case None
	case Top5Only
}


class HomePageViewModel: ObservableObject {
	
	@Published var activeTours: [Tour] = []
	@Published var filter: HomePageItemsFilter = .None
	
	private var allTours: [Tour] = []
	private var top5Tours: [Tour] = []
	
	private var subscription: AnyCancellable? = nil
	
	init() {}
	
	
	func subcribe(appStatePublisher: AnyPublisher<AppState, Never>) {
		self.subscription = appStatePublisher
			.sink { [weak self] newAppState in
				self?.update(withNewAppState: newAppState)
			}
	}
	
	
	func update(withNewAppState newAppState: AppState) {
		self.allTours = newAppState.allTours
		self.top5Tours = newAppState.top5ToursIDs.compactMap({ tourID in
			newAppState.toursDict[tourID]
		})
		
		self.activeTours = getActiveTours(fromFilter: filter)
	}
	
	
	func set(filter: HomePageItemsFilter) {
		self.filter = filter
		self.activeTours = getActiveTours(fromFilter: filter)
	}
	
	
	private func getActiveTours(fromFilter filter: HomePageItemsFilter) -> [Tour] {
		return switch filter {
		case .None: self.allTours
		case .Top5Only: self.top5Tours
		}
	}
}
