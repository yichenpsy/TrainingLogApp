import SwiftUI

struct PlanListView: View {
    var body: some View {
        VStack {
            Text("Training Log")
                .font(.largeTitle)
                .bold()
            
            Text("Choose today’s session")
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Training Log")
    }
}

#Preview {
    NavigationStack {
        PlanListView()
    }
    .environment(TrainingStore())
}
