import SwiftUI

struct PlanListView: View {
    @Environment(TrainingStore.self) private var store
    
    @State private var selectedPlan: TrainingPlan? = nil
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        PlanBuilderView()
                    } label: {
                        Label("Define Plan", systemImage: "plus.circle")
                    }
                }
                
                Section("Training Plans") {
                    ForEach(store.plans) { plan in
                        Button {
                            selectedPlan = plan
                        } label: {
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(plan.name)
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Text("\(plan.exercises.count) exercises")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text(patternText(for: plan))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Text("Start")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                            .fill(.black)
                                    )
                            }
                            .padding(.vertical, 6)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle("Training Plans")
            .navigationDestination(item: $selectedPlan) { plan in
                RecordTrainingView(plan: plan)
            }
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
