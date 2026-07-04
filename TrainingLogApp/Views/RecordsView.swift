import SwiftUI

/// Shows the history of saved sessions and links to each session detail.
struct RecordsView: View {
    @Environment(TrainingStore.self) private var store
    
    var body: some View {
        NavigationStack {
            List {
                if store.sessions.isEmpty {
                    Text("No training sessions yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(store.sessions) { session in
                        VStack(alignment: .leading, spacing: 8) {
                            NavigationLink {
                                RecordDetailView(session: session)
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(session.planName)
                                        .font(.headline)
                                    
                                    Text(session.date, format: .dateTime.day().month().year().hour().minute())
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    
                                    if !session.rpe.isEmpty {
                                        Text("RPE: \(session.rpe)")
                                            .font(.subheadline)
                                    }
                                }
                            }
                            
                            HStack(spacing: 8) {
                                Text("\(session.exerciseRecords.count) exercises")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Button {
                                    store.deleteSession(session)
                                } label: {
                                    Image(systemName: "trash")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Training Records")
        }
    }
}

#Preview {
    RecordsView()
        .environment(TrainingStore())
}
