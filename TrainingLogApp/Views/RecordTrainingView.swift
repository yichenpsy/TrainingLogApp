import SwiftUI

/// Records sets and session effort for a selected training plan.
struct RecordTrainingView: View {
    @Environment(TrainingStore.self) private var store
    
    let plan: TrainingPlan
    
    @State private var exerciseRecords: [ExerciseTrainingRecord]
    @State private var rpe: String = ""
    @State private var saved = false
    
    init(plan: TrainingPlan) {
        self.plan = plan
        
        // Start each exercise with one blank set so the form is ready for input.
        let records = plan.exercises.map { exercise in
            ExerciseTrainingRecord(
                exercise: exercise,
                sets: [TrainingSet()]
            )
        }
        
        _exerciseRecords = State(initialValue: records)
    }
    
    var body: some View {
        Form {
            Section("Plan") {
                Text(plan.name)
            }
            
            Section("Exercises") {
                ForEach(exerciseRecords.indices, id: \.self) { recordIndex in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(exerciseRecords[recordIndex].exercise.name)
                            .font(.headline)
                        
                        Text(exerciseRecords[recordIndex].exercise.movementPattern.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        ForEach(exerciseRecords[recordIndex].sets.indices, id: \.self) { setIndex in
                            TextField("Reps", text: $exerciseRecords[recordIndex].sets[setIndex].reps)
                            
                            TextField("Intensity", text: $exerciseRecords[recordIndex].sets[setIndex].intensity)
                            
                            TextField("Note", text: $exerciseRecords[recordIndex].sets[setIndex].note)
                        }
                        
                        Button("Add Set") {
                            // Appending to the nested state array creates another editable set row.
                            exerciseRecords[recordIndex].sets.append(TrainingSet())
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            
            Section("Rate of Perceived Exertion") {
                TextField("1(easy) - 3(hard)", text: $rpe)
            }
            
            Button("Save Training Session") {
                // Save a snapshot of the current form state as a completed session.
                let session = TrainingSession(
                    planName: plan.name,
                    rpe: rpe,
                    exerciseRecords: exerciseRecords
                )
                
                store.addSession(session)
                saved = true
            }
            
            if saved {
                Text("Saved")
                    .foregroundStyle(.green)
            }
        }
        .navigationTitle("Record Training")
    }
}

#Preview {
    let store = TrainingStore()
    
    NavigationStack {
        RecordTrainingView(plan: store.plans[0])
    }
    .environment(store)
}
