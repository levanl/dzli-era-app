//
//  CardManagerView.swift
//  DzliEra
//
//  Created by Levan Loladze on 06.03.24.
//

import SwiftUI
import SplineRuntime

struct CardManagerView: View {
    var body: some View {
        VStack {
            ContentView()
        }
    }
}

#Preview {
    CardManagerView()
}


struct ContentView: View {
    var body: some View {
        // fetching from cloud
        let url = URL(string: "https://build.spline.design/NAVqDg9ozc3CafQZQkVU/scene.splineswift")!

        // // fetching from local
        // let url = Bundle.main.url(forResource: "scene", withExtension: "splineswift")!

        try? SplineView(sceneFileURL: url).ignoresSafeArea(.all)
    }
}
