//
//
//  AsyncButton.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	


import SwiftUI


struct AsyncButton<Content: View>: View {
	
	@Binding var isLoading: Bool
	let action: () async -> Void
	let label: () -> Content
	
	@State private var runningTask: Task<(), Never>?
	
	private var isTaskRunning: Bool {
		runningTask != nil
	}
	
	var body: some View {
		Button(
			action: {
				if runningTask != nil { return }
				
				isLoading = true
				
				let task = Task {
					await action()
					await MainActor.run {
						self.runningTask = nil
						isLoading = false
					}
				}
				self.runningTask = task
			},
			label: {
				label()
			}
		)
		.disabled(isTaskRunning)
		.onDisappear {
			runningTask?.cancel()
			isLoading = false
		}
	}
}
