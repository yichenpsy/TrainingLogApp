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
    @Environment(TrainingStore.self) private var store
    
    var body: some View {
        TabView(selection: Binding(
            get: {
                store.selectedTab
            },
            set: { newTab in
                store.selectedTab = newTab
            }
        )) {
            PlanListView()
                .tabItem {
                    Label("Plans", systemImage: "list.bullet")
                }
                .tag(AppTab.plans)
            
            RecordsView()
                .tabItem {
                    Label("Records", systemImage: "clock")
                }
                .tag(AppTab.records)
            
            ExerciseListView()
                .tabItem {
                    Label("Exercises", systemImage: "figure.strengthtraining.traditional")
                }
                .tag(AppTab.exercises)
        }
    }
}

#Preview {
    ContentView()
        .environment(TrainingStore())
}
