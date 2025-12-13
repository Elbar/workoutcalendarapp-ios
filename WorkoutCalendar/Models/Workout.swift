//
//  Workout.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//

import Foundation

import SwiftUI
import Charts

// MARK: - Models/Workout.swift

struct Workout: Identifiable, Codable {
    let id: String
    let activityType: WorkoutType
    let startDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "workoutKey"
        case activityType = "workoutActivityType"
        case startDate = "workoutStartDate"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        let typeString = try container.decode(String.self, forKey: .activityType)
        activityType = WorkoutType(rawValue: typeString) ?? .other
        
        let dateString = try container.decode(String.self, forKey: .startDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        startDate = formatter.date(from: dateString) ?? Date()
    }
}

enum WorkoutType: String, Codable {
    case walkingRunning = "Walking/Running"
    case yoga = "Yoga"
    case water = "Water"
    case cycling = "Cycling"
    case strength = "Strength"
    case other = "Other"
    
    var icon: String {
        switch self {
        case .walkingRunning: return "figure.run"
        case .yoga: return "figure.yoga"
        case .water: return "figure.open.water.swim"
        case .cycling: return "bicycle"
        case .strength: return "dumbbell.fill"
        case .other: return "figure.mixed.cardio"
        }
    }
    
    var color: Color {
        switch self {
        case .walkingRunning: return .blue
        case .yoga: return .purple
        case .water: return .cyan
        case .cycling: return .green
        case .strength: return .orange
        case .other: return .gray
        }
    }
    
    var displayName: String {
        switch self {
        case .walkingRunning: return "Бег/Ходьба"
        case .yoga: return "Йога"
        case .water: return "Вода"
        case .cycling: return "Велосипед"
        case .strength: return "Силовая"
        case .other: return "Другое"
        }
    }
}
