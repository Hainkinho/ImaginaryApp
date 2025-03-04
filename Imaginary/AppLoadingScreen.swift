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
		VStack {
			ProgressView()
				.progressViewStyle(CircularProgressViewStyle(tint: .white))
			
			Text("loading...", comment: "Subtitle - AppLoadingScreen")
				.foregroundStyle(.white)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.black)
	}
}
