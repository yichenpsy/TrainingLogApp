//
//  Exercise.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 30.06.26.
//
/**
 Band-assisted Pull-up
 Squat
 Romanian Deadlift
 Pallof Press
 Farmer Carry
 */

import Foundation

/// Defines one exercise that can be reused in plans and training records.
struct Exercise: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var movementPattern: MovementPattern
    /// Optional preparation instruction shown before doing the exercise.
    var warmUp: String
    /// Describes how intensity is measured, such as kg, sec, band, or level.
    var intensityUnit: String
    var defaultIntensity: String
    /// Main technique cue or execution standard for the exercise.
    var howTo: String
    
    init(
        id: UUID = UUID(),
        name: String,
        movementPattern: MovementPattern,
        warmUp: String = "",
        intensityUnit: String = "",
        defaultIntensity: String = "",
        howTo: String = ""
    ) {
        self.id = id
        self.name = name
        self.movementPattern = movementPattern
        self.warmUp = warmUp
        self.intensityUnit = intensityUnit
        self.defaultIntensity = defaultIntensity
        self.howTo = howTo
    }
}
