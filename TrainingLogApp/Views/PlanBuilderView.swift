import SwiftUI

/// Form for creating a training plan from the exercises currently in the store.
struct PlanBuilderView: View {
    @Environment(TrainingStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    
    @State private var planName = ""
    /// Tracks selected exercises by ID so toggle state stays stable while the list renders.
    @State private var selectedExerciseIDs: Set<UUID> = []
    
    var body: some View {
        Form {
            Section("Plan Name") {
                TextField("e.g. Plan C", text: $planName)
            }
            
            Section("Choose Exercises") {
                ForEach(store.exercises) { exercise in
                    Toggle(isOn: binding(for: exercise)) {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                            Text(exercise.movementPattern.rawValue)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            
            Button("Save Plan") {
                // Preserve the store's exercise order when converting selected IDs to exercises.
                let selectedExercises = store.exercises.filter {
                    selectedExerciseIDs.contains($0.id)
                }
                
                let plan = TrainingPlan(
                    name: planName,
                    exercises: selectedExercises
                )
                
                store.addPlan(plan)
                dismiss()
            }
            // A plan needs both a name and at least one exercise.
            .disabled(planName.trimmingCharacters(in: .whitespaces).isEmpty || selectedExerciseIDs.isEmpty)
        }
        .navigationTitle("Define Plan")
    }
    
    /// Bridges the selected ID set into the Binding<Bool> required by Toggle.
    func binding(for exercise: Exercise) -> Binding<Bool> {
        Binding(
            get: {
                selectedExerciseIDs.contains(exercise.id)
            },
            set: { isSelected in
                if isSelected {
                    selectedExerciseIDs.insert(exercise.id)
                } else {
                    selectedExerciseIDs.remove(exercise.id)
                }
            }
        )
    }
}

#Preview {
    NavigationStack {
        PlanBuilderView()
    }
    .environment(TrainingStore())
}
