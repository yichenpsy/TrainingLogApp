# ADR 0001: Local Persistence Strategy

## Status

Accepted

## Context

The Training Log App currently stores all training data in memory through `TrainingStore`.

The app contains three main data collections:

* `exercises`
* `plans`
* `sessions`

This works during one app session, but the data is lost when the app is closed or restarted. For the next step, the app needs local persistence so that user-created exercises, training plans, and training sessions remain available after restarting the app.

The app is a SwiftUI Abschlussprojekt. The main goal is to keep the implementation simple, stable, understandable, and suitable for the current project scope.

## Decision

The app will use a local JSON file with Swift `Codable` for data persistence.

All main model types will conform to `Codable`, and the app data will be saved as one structured JSON file.

A new data container model will be introduced:

```swift
struct TrainingData: Codable {
    var exercises: [Exercise]
    var plans: [TrainingPlan]
    var sessions: [TrainingSession]
}
```

`TrainingStore` will be responsible for loading and saving this data.

The basic workflow will be:

```text
App starts
→ TrainingStore loads saved data from local JSON file

User creates an exercise, plan, or training session
→ TrainingStore updates the in-memory data
→ TrainingStore saves the updated data to the JSON file
```

## Alternatives Considered

### UserDefaults

`UserDefaults` was considered but rejected because the app data is structured and can become more complex over time. `UserDefaults` is better suited for small settings, not for storing complete training records.

### SwiftData

SwiftData was considered but postponed.

SwiftData would be a more database-like solution, but it would require a larger refactoring of the current model layer. The current models are implemented as Swift structs. SwiftData usually works with `@Model` classes and object relationships, which would make the project more complex.

For the current Abschlussprojekt scope, this would increase implementation risk without being necessary for the main use cases.

### Core Data

Core Data was rejected for the current version because it is more complex than necessary for this app.

## Consequences

### Advantages

* Simple implementation
* Works on real iPhone and iPad devices
* Fits the current Swift struct-based model design
* Keeps the project understandable
* Reduces the risk of build errors and warnings
* Sufficient for the current MVP and Abschlussprojekt requirements

### Limitations

* Data is stored only locally on one device
* No automatic sync between iPhone and iPad
* No multi-user support
* No cloud backup
* No advanced database queries
* Manual migration may be needed if the data model changes later

## Future Considerations

If the app becomes larger after the Abschlussprojekt, the persistence strategy can be upgraded.

Possible future options include:

* SwiftData for more structured local database storage
* CloudKit or iCloud sync for sharing data between devices
* A backend database if user accounts or multi-device access become necessary

For the current version, JSON file persistence with `Codable` is the preferred solution because it is simple, stable, and sufficient for the app’s current requirements.

