import SwiftUI

// Yichen Zhong, 1 Person
//
// UC Trainingsplan auswählen
// UC Trainingseinheit erfassen
// UC Bewegung definieren
// UC Trainingsplan definieren
// UC Trainingsverlauf anzeigen

//  ContentView.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 27.06.26.

struct ContentView: View {
    @Environment(TrainingStore.self) private var store
    
    var body: some View {
        NavigationStack {
            PlanListView()
        }
    }
}

#Preview {
    ContentView()
        .environment(TrainingStore())
}
