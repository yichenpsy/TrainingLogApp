import SwiftUI

struct PlanBuilderView: View {
    @Environment(TrainingStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    
    @State private var planName = ""
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
            .disabled(planName.trimmingCharacters(in: .whitespaces).isEmpty || selectedExerciseIDs.isEmpty)
        }
        .navigationTitle("Define Plan")
    }
    
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
