//
//  TrainingLogAppApp.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 27.06.26.
//

import SwiftUI

@main
struct TrainingLogAppApp: App {
    @State private var store = TrainingStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
