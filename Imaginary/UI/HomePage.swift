//
//
//  HomePage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//

import SwiftUI

extension View {
	
	func setupHomePageNavbar(tappedMoreButton: @escaping () -> Void) -> some View {
		self
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					HStack {
						Image(Constants.companyLogoImageString)
							.resizable()
							.scaledToFit()
							.frame(width: 40, height: 40)
						
						Text(Constants.appName)
							.fontWeight(.bold)
					}
				}
				
				ToolbarItem(placement: .topBarTrailing) {
					Button(action: tappedMoreButton) {
						Image(systemName: "ellipsis")
							.rotationEffect(.init(degrees: 90))
							.foregroundStyle(.black)
							.frame(width: 44, height: 44)  // Ensures the button is easily tappable
							.background(Color.white.opacity(0.00001))
					}
				}
			}
	}
}



struct HomePage: View {
	
	enum HomePageItemsFilter: CaseIterable {
		case None
		case Top5Only
	}
	
	@State private var activeItemsFilter = HomePageItemsFilter.None
	
	var body: some View {
		VStack(spacing: 0) {
			
			topFilterToolbar
			.padding(.top, 1) // Prevents that the buttons background Color
			
			List {
				ForEach(1 ... 100, id: \.self) { i in
					Button(action: {}) {
						HomeListCell(
							title: "Titel",
							description: "Short Description",
							imageURL: URL.placeholderImageURL,
							endDate: Date(),
							localizedPrice: "XX€"
						)
					}
				}
			}
			.listStyle(.plain)
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
	HomePage()
}
