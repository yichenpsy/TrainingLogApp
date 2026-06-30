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

struct Exercise: Identifiable, Hashable {
    let id: UUID
    var name: String
    var movementPattern: MovementPattern
    var warmUp: String
    var intensityUnit: String
    var defaultIntensity: String
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
