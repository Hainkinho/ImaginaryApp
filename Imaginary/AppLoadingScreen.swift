//
//
//  AppLoadingScreen.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import SwiftUI

struct AppLoadingScreen: View {

	var body: some View {
		VStack(spacing: 10) {
			ProgressView()
				.progressViewStyle(CircularProgressViewStyle(tint: .black))
			
			Text("loading data...", comment: "Subtitle - AppLoadingScreen")
				.foregroundStyle(.black)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.white)
	}
}
