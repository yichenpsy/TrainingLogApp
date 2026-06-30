//
//  ExerciseListView.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 30.06.26.
//

import SwiftUI

/// Shows saved exercises and provides navigation to the exercise form.
struct ExerciseListView: View {
    @Environment(TrainingStore.self) private var store
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        ExerciseFormView()
                    } label: {
                        Label("Define Exercise", systemImage: "plus.circle")
                    }
                }
                
                Section("Saved Exercises") {
                    if store.exercises.isEmpty {
                        Text("No exercises yet")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(store.exercises) { exercise in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(exercise.name)
                                    .font(.headline)
                                
                                Text(exercise.movementPattern.rawValue)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                if !exercise.defaultIntensity.isEmpty {
                                    Text("Default: \(exercise.defaultIntensity)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Exercises")
        }
    }
}

#Preview {
    ExerciseListView()
        .environment(TrainingStore())
}
