import SwiftUI

struct PlanListView: View {
    @Environment(TrainingStore.self) private var store
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.plans) { plan in
                    NavigationLink {
                        RecordTrainingView(plan: plan)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(plan.name)
                                .font(.headline)
                            
                            Text("\(plan.exercises.count) exercises")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Text(patternText(for: plan))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Training Plans")
        }
    }
    
    func patternText(for plan: TrainingPlan) -> String {
        let patterns = plan.exercises.map { $0.movementPattern.rawValue }
        return patterns.joined(separator: " · ")
    }
}

#Preview {
    PlanListView()
        .environment(TrainingStore())
}
