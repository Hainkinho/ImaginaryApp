//
//
//  DetailsContainerPage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	
import SwiftUI

struct DetailsContainerPage: View {
	
	@ObservedObject var vm: DetailsPageViewModel
	
	var body: some View {
		DetailsPage(
			showcaseImageURL: vm.tourDetails?.fullResImageURL ?? vm.tour.snapshotImageURL,
			title: vm.tour.title,
			description: vm.tourDetails?.longDescription ?? vm.tour.shortDescription,
			isBookable: true, // TODO:
			startDate: vm.tour.startDate,
			endDate: vm.tour.endDate
		)
	}
}
