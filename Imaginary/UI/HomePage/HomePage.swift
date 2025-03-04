//
//
//  HomePage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//

import SwiftUI

enum HomePageListButtonConfig {
	case NavigationLink
	case Button(action: (TourID) -> Void)
}

struct HomePage: View {
	
	let tours: [Tour]
	@Binding var activeItemsFilter: HomePageItemsFilter
	
	let listButtonConfig: HomePageListButtonConfig
	
	let refreshAllTours: () async -> Void
	
	
	var body: some View {
		VStack(spacing: 0) {
			
			topFilterToolbar
			.padding(.top, 1) // Prevents that the buttons background Color
			
			List {
				ForEach(tours) { tour in
					switch listButtonConfig {
					case .NavigationLink:
						NavigationLink(value: tour.id) {
							HomeListCell(
								title: tour.title,
								description: tour.shortDescription,
								imageURL: tour.snapshotImageURL,
								endDate: tour.endDate,
								localizedPrice: tour.localizedPrice
							)
						}
					case .Button(let action):
						Button(action: {
							action(tour.id)
						}) {
							HomeListCell(
								title: tour.title,
								description: tour.shortDescription,
								imageURL: tour.snapshotImageURL,
								endDate: tour.endDate,
								localizedPrice: tour.localizedPrice
							)
						}
					}
				}
			}
			.listStyle(.plain)
			.refreshable {
				await refreshAllTours()
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.white)
	}
	
	
	var topFilterToolbar: some View {
		HStack(spacing: 0) {
			ForEach([HomePageItemsFilter.None, .Top5Only], id: \.self) { filter in
				Button(action: { self.activeItemsFilter = filter }) {
					let isSelected = activeItemsFilter == filter
					Text(getTopToolbarButtonTitle(for: filter))
						.foregroundStyle(isSelected ? .white : .black)
						.fontWeight(isSelected ? .bold : .medium)
						.opacity(isSelected ? 1 : 0.8)
						.frame(height: 70)
						.frame(maxWidth: .infinity)
						.background(isSelected ? Color.blue : .black.opacity(0.1))
				}
				.buttonStyle(.plain)
			}
		}
		.frame(maxWidth: .infinity)
	}
	
	
	func getTopToolbarButtonTitle(for filter: HomePageItemsFilter) -> String {
		switch filter {
		case .None:
			return String(localized: "ALL", comment: "TopNavigationBar Button Title - HomePage")
		case .Top5Only:
			return String(localized: "TOP 5", comment: "TopNavigationBar Button Title - HomePage")
		}
	}
}



#Preview {
	HomePage(
		tours: (0 ... 100).map { Tour.createExample(withID: "\($0)") },
		activeItemsFilter: .constant(.None),
		listButtonConfig: .NavigationLink,
		refreshAllTours: {}
	)
}
