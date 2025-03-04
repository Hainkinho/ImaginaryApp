//
//
//  ImaginaryApp.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import SwiftUI

@main
struct MainApp: App {
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


struct ContentView: View {
	
	@State private var compositionRootResult: CompositionRootResult? = nil
	
	func viewDidAppear() async {
		let compositionRoot = CompositionRoot()
		self.compositionRootResult = await compositionRoot.assembleAppsObjectGraph()
	}
	
	var body: some View {
		VStack {
			if let crResult = compositionRootResult {
				HomeContainerPage(
					createHomePage: {
						crResult.mainPagesCreator.createHomePage()
					}
				)
			} else {
				AppLoadingScreen()
			}
		}
		.task {
			await viewDidAppear()
		}
	}
}
