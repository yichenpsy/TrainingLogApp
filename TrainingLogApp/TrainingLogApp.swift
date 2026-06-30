//
//  TrainingLogAppApp.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 27.06.26.
//

import SwiftUI

@main
struct TrainingLogApp: App {
    /// Single source of truth injected into every view through the SwiftUI environment.
    @State private var store = TrainingStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
