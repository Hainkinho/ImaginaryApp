//
//
//  HomeContainerPage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import SwiftUI

struct AdaptiveHomeNavigationLayout: View {
	
	@Environment(\.horizontalSizeClass) private var sizeClass
	
	let createHomePage: () -> HomePage
	
	var body: some View {
		if sizeClass == .compact {
			NavigationStack {
				createHomePage()
					.navigationBarTitleDisplayMode(.inline)
					.setupHomePageNavbar(tappedMoreButton: {
						// TODO: Add logic here. The assignment doesn't specify details, so this needs clarification.
					})
			}
		} else {
			NavigationStack {
				HStack(spacing: 0) {
					createHomePage()
					
					VStack {
						Image(Constants.companyLogoImageString)
							.resizable()
							.frame(width: 100, height: 100)
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				}
				.setupHomePageNavbar(tappedMoreButton: {
					// TODO: Add logic here. The assignment doesn't specify details, so this needs clarification.
				})
			}
		}
	}
}
