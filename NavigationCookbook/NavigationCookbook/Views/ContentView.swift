/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The main content view the app uses to present the navigation experience
 picker and change the app navigation architecture based on the user selection.
 */

import SwiftUI

struct ContentView: View {
	@SceneStorage("experience") private var experience: Experience?
	@SceneStorage("navigation") private var navigationData: Data?
	@StateObject private var navigationModel = NavigationModel()
	@State private var showExperiencePicker = false
	
	var body: some View {
		Group {
			StackContentView(showExperiencePicker: $showExperiencePicker)
		}
		.environmentObject(navigationModel)
		.sheet(isPresented: $showExperiencePicker) {
			ExperiencePicker(experience: $experience)
		}
		.task {
			if let jsonData = navigationData {
				navigationModel.jsonData = jsonData
			}
			for await _ in navigationModel.objectWillChangeSequence {
				navigationData = navigationModel.jsonData
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
