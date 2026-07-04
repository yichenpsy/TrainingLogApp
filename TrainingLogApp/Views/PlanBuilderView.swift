import SwiftUI

struct PlanBuilderView: View {
    @Environment(TrainingStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    
    let planToEdit: TrainingPlan?
    
    @State private var planName: String
    @State private var selectedExerciseIDs: Set<UUID>
    
    init(planToEdit: TrainingPlan? = nil) {
        self.planToEdit = planToEdit
        
        _planName = State(initialValue: planToEdit?.name ?? "")
        
        let existingIDs = planToEdit?.exercises.map { $0.id } ?? []
        _selectedExerciseIDs = State(initialValue: Set(existingIDs))
    }
    
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
            
            Button(planToEdit == nil ? "Save Plan" : "Update Plan") {
                savePlan()
            }
            .disabled(planName.trimmingCharacters(in: .whitespaces).isEmpty || selectedExerciseIDs.isEmpty)
        }
        .navigationTitle(planToEdit == nil ? "Define Plan" : "Edit Plan")
    }
    
    private func savePlan() {
        let selectedExercises = store.exercises.filter {
            selectedExerciseIDs.contains($0.id)
        }
        
        let plan = TrainingPlan(
            id: planToEdit?.id ?? UUID(),
            name: planName,
            exercises: selectedExercises
        )
        
        if planToEdit == nil {
            store.addPlan(plan)
        } else {
            store.updatePlan(plan)
        }
        
        dismiss()
    }
    
    private func binding(for exercise: Exercise) -> Binding<Bool> {
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
