//
//  ExerciseFormView.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 30.06.26.
//

import SwiftUI

/// Form for creating a reusable exercise definition.
struct ExerciseFormView: View {
    /// Shared store receives the saved exercise, while dismiss closes the form.
    @Environment(TrainingStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var selectedPattern: MovementPattern = .squat
    @State private var warmUp = ""
    @State private var intensityUnit = ""
    @State private var defaultIntensity = ""
    @State private var howTo = ""
    
    var body: some View {
        Form {
            Section("Basic Information") {
                TextField("Exercise name", text: $name)
                
                Picker("Movement Pattern", selection: $selectedPattern) {
                    ForEach(MovementPattern.allCases) { pattern in
                        Text(pattern.rawValue).tag(pattern)
                    }
                }
            }
            
            Section("Training Details") {
                TextField("Warm-up", text: $warmUp)
                TextField("Intensity unit", text: $intensityUnit)
                TextField("Default intensity", text: $defaultIntensity)
            }
            
            Section("How to do") {
                TextField("Key standard", text: $howTo, axis: .vertical)
                    .lineLimit(3...5)
            }
            
            Button("Save Exercise") {
                // Build a domain model from the form state before adding it to the store.
                let exercise = Exercise(
                    name: name,
                    movementPattern: selectedPattern,
                    warmUp: warmUp,
                    intensityUnit: intensityUnit,
                    defaultIntensity: defaultIntensity,
                    howTo: howTo
                )
                
                store.addExercise(exercise)
                dismiss()
            }
            // A named exercise is the minimum required data for saving.
            .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .navigationTitle("Define Exercise")
    }
}

#Preview {
    NavigationStack {
        ExerciseFormView()
    }
    .environment(TrainingStore())
}
