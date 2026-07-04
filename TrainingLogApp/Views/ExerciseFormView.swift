//
//  ExerciseFormView.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 30.06.26.
//

import SwiftUI

struct ExerciseFormView: View {
    @Environment(TrainingStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    
    let exerciseToEdit: Exercise?
    
    @State private var name: String
    @State private var selectedPattern: MovementPattern
    @State private var warmUp: String
    @State private var intensityUnit: String
    @State private var defaultIntensity: String
    @State private var howTo: String
    
    init(exerciseToEdit: Exercise? = nil) {
        self.exerciseToEdit = exerciseToEdit
        
        _name = State(initialValue: exerciseToEdit?.name ?? "")
        _selectedPattern = State(initialValue: exerciseToEdit?.movementPattern ?? .squat)
        _warmUp = State(initialValue: exerciseToEdit?.warmUp ?? "")
        _intensityUnit = State(initialValue: exerciseToEdit?.intensityUnit ?? "")
        _defaultIntensity = State(initialValue: exerciseToEdit?.defaultIntensity ?? "")
        _howTo = State(initialValue: exerciseToEdit?.howTo ?? "")
    }
    
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
            
            Button(exerciseToEdit == nil ? "Save Exercise" : "Update Exercise") {
                saveExercise()
            }
            .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .navigationTitle(exerciseToEdit == nil ? "Define Exercise" : "Edit Exercise")
    }
    
    private func saveExercise() {
        let exercise = Exercise(
            id: exerciseToEdit?.id ?? UUID(),
            name: name,
            movementPattern: selectedPattern,
            warmUp: warmUp,
            intensityUnit: intensityUnit,
            defaultIntensity: defaultIntensity,
            howTo: howTo
        )
        
        if exerciseToEdit == nil {
            store.addExercise(exercise)
        } else {
            store.updateExercise(exercise)
        }
        
        dismiss()
    }
}

#Preview {
    NavigationStack {
        ExerciseFormView()
    }
    .environment(TrainingStore())
}
