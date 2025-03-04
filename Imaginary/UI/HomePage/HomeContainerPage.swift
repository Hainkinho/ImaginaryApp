//
//
//  HomeContainerPage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import SwiftUI

struct HomeContainerPage: View {
	
	@StateObject var vm: HomePageViewModel
	let listButtonConfig: HomePageListButtonConfig
	let tappedOnCell: (Tour) -> Void
	
	var activeItemsFilterBinding: Binding<HomePageItemsFilter> {
		Binding(
			get: { vm.filter },
			set: { vm.set(filter: $0) }
		)
	}
	
	var body: some View {
		HomePage(
			tours: vm.activeTours,
			activeItemsFilter: activeItemsFilterBinding,
			listButtonConfig: listButtonConfig,
			refreshAllTours: {
				await vm.refreshAllTours()
			}
		)
		.customAlertInfo($vm.activeAlert)
	}
	
}
