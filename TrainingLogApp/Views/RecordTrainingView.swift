import SwiftUI

struct RecordTrainingView: View {
    @Environment(TrainingStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    
    let plan: TrainingPlan
    
    @State private var currentExerciseIndex = 0
    @State private var exerciseRecords: [ExerciseTrainingRecord]
    @State private var restSeconds: Int? = nil
    
    @State private var selectedRestText: String? = nil
    @State private var showCustomRestInput = false
    @State private var customRestSeconds = ""
    @State private var finishedSession: TrainingSession? = nil
    
    init(plan: TrainingPlan) {
        self.plan = plan
        
        let records = plan.exercises.map { exercise in
            ExerciseTrainingRecord(
                exercise: exercise,
                sets: [
                    TrainingSet(reps: "6", intensity: exercise.defaultIntensity, note: ""),
                    TrainingSet(reps: "", intensity: "", note: ""),
                    TrainingSet(reps: "", intensity: "", note: "")
                ]
            )
        }
        
        _exerciseRecords = State(initialValue: records)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header
                exerciseCard
                mediaPlaceholder
                setsInputCard
                timerButtons
                lastRecordBox
                navigationButtons
            }
            .padding()
        }
        .navigationTitle("Record Training")
        .navigationDestination(item: $finishedSession) { session in
            RecordDetailView(session: session)
        }
        .alert("Custom Rest", isPresented: $showCustomRestInput) {
            TextField("Seconds", text: $customRestSeconds)
            
            Button("Add") {
                addCustomRestTime()
            }
            
            Button("Cancel", role: .cancel) {
                customRestSeconds = ""
            }
        } message: {
            Text("Enter rest time in seconds.")
        }
    }
}

extension RecordTrainingView {
    
    private var currentRecord: ExerciseTrainingRecord {
        exerciseRecords[currentExerciseIndex]
    }
    
    private var currentExercise: Exercise {
        currentRecord.exercise
    }
    
    private var header: some View {
        HStack {
            Text(plan.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("\(currentExerciseIndex + 1) / \(plan.exercises.count)")
                .font(.headline)
                .padding(.horizontal, 28)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.opacity(0.08))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                )
        }
    }
    
    private var exerciseCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(currentExercise.name)
                .font(.title3)
                .fontWeight(.bold)
            
            Text("Pattern: \(currentExercise.movementPattern.rawValue)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.05))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray.opacity(0.25), lineWidth: 1)
        )
    }
    
    private var mediaPlaceholder: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.gray.opacity(0.08))
            .frame(height: 190)
            .overlay {
                VStack(spacing: 8) {
                    if !currentExercise.howTo.isEmpty {
                        Text(currentExercise.howTo)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    } else {
                        Text("Photo / video / How to do\nplaceholder")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray.opacity(0.25), lineWidth: 1)
            )
    }
}

extension RecordTrainingView {
    
    private var setsInputCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sets")
                .font(.title2)
                .fontWeight(.bold)
            
            HStack {
                Text("reps")
                    .fontWeight(.semibold)
                    .frame(width: 70, alignment: .leading)
                
                Text("Intensity")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Notes")
                    .fontWeight(.semibold)
                    .frame(width: 110, alignment: .leading)
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            ForEach(exerciseRecords[currentExerciseIndex].sets.indices, id: \.self) { setIndex in
                HStack {
                    TextField("0", text: $exerciseRecords[currentExerciseIndex].sets[setIndex].reps)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 70)
                    
                    TextField("Intensity", text: $exerciseRecords[currentExerciseIndex].sets[setIndex].intensity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Note", text: $exerciseRecords[currentExerciseIndex].sets[setIndex].note)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 110)
                }
            }
            
            Button {
                exerciseRecords[currentExerciseIndex].sets.append(TrainingSet())
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray.opacity(0.25), lineWidth: 1)
        )
    }
}

extension RecordTrainingView {
    
    private var timerButtons: some View {
        HStack(spacing: 10) {
            restButton(title: "30 sec", seconds: 30)
            restButton(title: "60 sec", seconds: 60)
            restButton(title: "90 sec", seconds: 90)
            restButton(title: "custom", seconds: nil)
        }
    }
    
    private func currentActiveSetIndex() -> Int {
        let sets = exerciseRecords[currentExerciseIndex].sets
        
        for index in sets.indices.reversed() {
            let set = sets[index]
            
            let hasInput =
                !set.reps.trimmingCharacters(in: .whitespaces).isEmpty ||
                !set.intensity.trimmingCharacters(in: .whitespaces).isEmpty ||
                !set.note.trimmingCharacters(in: .whitespaces).isEmpty
            
            if hasInput {
                return index
            }
        }
        
        return 0
    }
    
    private func addRestTimeToCurrentSet(title: String) {
        selectedRestText = title
        
        if exerciseRecords[currentExerciseIndex].sets.isEmpty {
            exerciseRecords[currentExerciseIndex].sets.append(TrainingSet())
        }
        
        let setIndex = currentActiveSetIndex()
        let restText = "Rest: \(title)"
        let oldNote = exerciseRecords[currentExerciseIndex].sets[setIndex].note
            .trimmingCharacters(in: .whitespaces)
        
        if oldNote.isEmpty {
            exerciseRecords[currentExerciseIndex].sets[setIndex].note = restText
        } else {
            exerciseRecords[currentExerciseIndex].sets[setIndex].note = "\(oldNote); \(restText)"
        }
    }
    
    private func addCustomRestTime() {
        let trimmedSeconds = customRestSeconds.trimmingCharacters(in: .whitespaces)
        
        if trimmedSeconds.isEmpty {
            return
        }
        
        let restText = "\(trimmedSeconds) sec"
        addRestTimeToCurrentSet(title: restText)
        
        customRestSeconds = ""
    }
    
    private func restButton(title: String, seconds: Int?) -> some View {
        Button {
            if seconds == nil {
                showCustomRestInput = true
            } else {
                addRestTimeToCurrentSet(title: title)
            }
        } label: {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
        }
        .foregroundStyle(.primary)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(.gray.opacity(selectedRestText == title ? 0.18 : 0.06))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(.gray.opacity(0.25), lineWidth: 1)
        )
    }
}

extension RecordTrainingView {
    
    private var lastRecordBox: some View {
        Text(lastRecordText)
            .font(.headline)
            .foregroundStyle(.green)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(.green.opacity(0.10))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.green.opacity(0.45), lineWidth: 1)
            )
    }
    
    private var lastRecordText: String {
        let previousSessions = store.sessions.reversed()
        
        for session in previousSessions {
            for record in session.exerciseRecords {
                if record.exercise.id == currentExercise.id,
                   let firstSet = record.sets.first {
                    return "Last: \(firstSet.reps) reps with \(firstSet.intensity)"
                }
            }
        }
        
        return "Last: no previous record"
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 20) {
            Button {
                goBack()
            } label: {
                Text("Back")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .foregroundStyle(.black)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(.gray.opacity(0.06))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.gray.opacity(0.25), lineWidth: 1)
            )
            
            Button {
                goNextOrFinish()
            } label: {
                Text(currentExerciseIndex == plan.exercises.count - 1 ? "Finish" : "Next")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(.black)
            )
        }
    }
    
    private func goBack() {
        if currentExerciseIndex > 0 {
            currentExerciseIndex -= 1
            restSeconds = nil
        }
    }
    
    private func goNextOrFinish() {
        if currentExerciseIndex < plan.exercises.count - 1 {
            currentExerciseIndex += 1
            restSeconds = nil
        } else {
            saveSession()
        }
    }
    
    private func saveSession() {
        let session = TrainingSession(
            planName: plan.name,
            rpe: "",
            exerciseRecords: cleanedExerciseRecords
        )
        
        store.addSession(session)
        store.selectedTab = .records
    }
    
    private var cleanedExerciseRecords: [ExerciseTrainingRecord] {
        exerciseRecords.map { record in
            let cleanedSets = record.sets.filter { set in
                !set.reps.trimmingCharacters(in: .whitespaces).isEmpty ||
                !set.intensity.trimmingCharacters(in: .whitespaces).isEmpty ||
                !set.note.trimmingCharacters(in: .whitespaces).isEmpty
            }
            
            return ExerciseTrainingRecord(
                exercise: record.exercise,
                sets: cleanedSets
            )
        }
    }
}
