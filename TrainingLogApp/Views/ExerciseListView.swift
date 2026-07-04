//
//  ExerciseListView.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 30.06.26.
//

import SwiftUI

struct ExerciseListView: View {
    @Environment(TrainingStore.self) private var store
    
    @State private var exerciseToEdit: Exercise? = nil
    @State private var showCannotDeleteAlert = false
    
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
                            HStack(spacing: 12) {
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
                                
                                Spacer()
                                
                                Button("Edit") {
                                    exerciseToEdit = exercise
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                
                                Button {
                                    let deleted = store.deleteExercise(exercise)
                                    
                                    if !deleted {
                                        showCannotDeleteAlert = true
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Exercises")
            .sheet(item: $exerciseToEdit) { exercise in
                NavigationStack {
                    ExerciseFormView(exerciseToEdit: exercise)
                }
            }
            .alert("Cannot Delete Exercise", isPresented: $showCannotDeleteAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("This exercise is used in a training plan. Remove it from the plan before deleting it.")
            }
        }
    }
}

#Preview {
    ExerciseListView()
        .environment(TrainingStore())
}
