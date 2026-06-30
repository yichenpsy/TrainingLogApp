import SwiftUI

// Yichen Zhong, 1 Person
//
// Yichen Zhong, 1 Person
// UC Trainingsplan auswählen
// UC Trainingseinheit erfassen
// UC Trainingsverlauf anzeigen
// UC Übung definieren
// UC Trainingsplan definieren

//  ContentView.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 27.06.26.

import SwiftUI

/// Root tab layout for the three main workflows: plans, records, and exercises.
struct ContentView: View {
    var body: some View {
        TabView {
            PlanListView()
                .tabItem {
                    Label("Plans", systemImage: "list.bullet")
                }
            
            RecordsView()
                .tabItem {
                    Label("Records", systemImage: "clock")
                }
            
            ExerciseListView()
                .tabItem {
                    Label("Exercises", systemImage: "figure.strengthtraining.traditional")
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(TrainingStore())
}
