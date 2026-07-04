import SwiftUI

struct PlanListView: View {
    @Environment(TrainingStore.self) private var store
    
    @State private var selectedPlan: TrainingPlan? = nil
    @State private var planToEdit: TrainingPlan? = nil
    
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
                        HStack(alignment: .center, spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(plan.name)
                                    .font(.headline)
                                
                                Text(patternText(for: plan))
                                    .font(.subheadline)
                                    .foregroundStyle(.primary)
                                
                                HStack(spacing: 16) {
                                    Button("Edit") {
                                        planToEdit = plan
                                    }
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.gray)
                                    .buttonStyle(.plain)
                                    
                                    Button {
                                        store.deletePlan(plan)
                                    } label: {
                                        Image(systemName: "trash")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                selectedPlan = plan
                            } label: {
                                Text("Start")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.black)
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Training Plans")
            .navigationDestination(item: $selectedPlan) { plan in
                RecordTrainingView(plan: plan)
            }
            .sheet(item: $planToEdit) { plan in
                NavigationStack {
                    PlanBuilderView(planToEdit: plan)
                }
            }
        }
    }
    
    private func patternText(for plan: TrainingPlan) -> String {
        let patterns = plan.exercises.map { $0.movementPattern.rawValue }
        return patterns.joined(separator: " · ")
    }
}

#Preview {
    PlanListView()
        .environment(TrainingStore())
}
